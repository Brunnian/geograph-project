<?php
/**
 * $Project: GeoGraph $
 * $Id: clusters.php 5786 2009-09-12 10:18:04Z barry $
 * 
 * GeoGraph geographic photo archive project
 * This file copyright (C) 2008 Barry Hunter (geo@barryhunter.co.uk)
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

require_once('geograph/global.inc.php');
init_session();




$smarty = new GeographPage;
$template = 'finder_bytag.tpl';

if (!empty($_GET['q']) || !empty($_GET['user_id'])) {
	$q=trim($_GET['q']);

	$sphinx = new sphinxwrapper($q);

	//gets a cleaned up verion of the query (suitable for filename etc)
	$cacheid = $sphinx->q;

	$sphinx->pageSize = $pgsize = 15;

	$pg = (!empty($_GET['page']))?intval(str_replace('/','',$_GET['page'])):0;
	if (empty($pg) || $pg < 1) {$pg = 1;}

	$cacheid .=".".$pg;
        if (!empty($_GET['user_id']))
		$cacheid .=".".intval($_GET['user_id']);

	if (!$smarty->is_cached($template, $cacheid)) {

		$sphinx->processQuery();

                if (preg_match('/@grid_reference \(/',$sphinx->q) && preg_match('/^\w{1,2}\d{4}$/',$sphinx->qclean)) {
                        $smarty->assign('gridref',$sphinx->qclean);
                }

		$sphinx->sort = "@weight DESC, @id ASC"; //this is the WITHIN GROUP ordering

		$client = $sphinx->_getClient();
		$client->SetArrayResult(true);

		if (!empty($_GET['user_id'])) {
			$client->setFilter("user_id",array(intval($_GET['user_id'])));
			$smarty->assign("user_id",$user_id = intval($_GET['user_id']));
		}

		$sphinx->SetGroupBy('all_tag_id', SPH_GROUPBY_ATTR, '@count DESC');
		$res = $sphinx->groupByQuery($pg,'tagsoup');

		#$sphinx->returnIds($pg,'tagsoup');
		#$res = $sphinx->res;


		$imageids = array();
		$tagids = array();
		if (!empty($res['matches'])) {
			foreach ($res['matches'] as $idx => $row) {
				$imageids[$idx] = $row['id'];
				$tagids[] = $row['attrs']['@groupby'];
			}
		}

		if (!empty($imageids)) {
			$where = "tag_id IN(".join(",",$tagids).")";

			$db = GeographDatabaseConnection(true);

			$ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;
			$rows = $db->getAssoc("
			select tag_id,prefix,tag
			from tag 
			where status =1 and $where
			limit $pgsize");

			$imagelist = new ImageList();
			$imagelist->getImagesByIdList($imageids,"gridimage_id,title,realname,user_id,grid_reference,credit_realname");
	
			//imagelist profiles all images, including duplicates, but in rare cases wont contain all images in imageids (rejections) - so we have to do things carefully. 
			foreach ($imagelist->images as $idx => $image) {
				
				$res_id = array_search($image->gridimage_id,$imageids);	
				unset($imageids[$res_id]); //array_search finds them in order, so remove them once used to move down the list
				
				$tag_id = $res['matches'][$res_id]['attrs']['@groupby'];
				$imagelist->images[$idx]->count = $res['matches'][$res_id]['attrs']['@count'];
				$imagelist->images[$idx]->tag = $rows[$tag_id];
			}
						
		
			$smarty->assign_by_ref('results', $imagelist->images);
			$smarty->assign("query_info",$sphinx->query_info);

			if ($sphinx->numberOfPages > 1) {
				$smarty->assign('pagesString', pagesString($pg,$sphinx->numberOfPages,$_SERVER['PHP_SELF']."?q=".urlencode($q).(empty($user_id)?'':'&amp;user_id='.intval($user_id))."&amp;page=") );
				$smarty->assign("offset",(($pg -1)* $sphinx->pageSize)+1);
			}
			$ADODB_FETCH_MODE = $prev_fetch_mode;
			
			
			if (count($imagelist->images) < 9) {
				$smarty->assign('thumbw',213);
				$smarty->assign('thumbh',160);
			} else {
				$smarty->assign('thumbw',120);
				$smarty->assign('thumbh',120);
			}
			
		}
	}
	
	$smarty->assign("q",$sphinx->qclean);

}

if (isset($_GET['popup'])) {
	$smarty->assign("popup",1);
}

$smarty->display($template,$cacheid);
