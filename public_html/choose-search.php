<?php
/**
 * $Project: GeoGraph $
 * $Id: staticpage.php 6962 2010-12-09 14:56:48Z geograph $
 * 
 * GeoGraph geographic photo archive project
 * This file copyright (C) 2005 Paul Dixon (paul@elphin.com)
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


//next, we want to be sure you can only view pages intended for static viewing
$template='choose-search.tpl';

$smarty = new GeographPage;

//you must be logged in to submit images
$USER->mustHavePerm("basic");




if (isset($_GET['submit'])) { //We use GET (rather than POST) so the back button can still work :(
	$keys = array_keys($_GET['submit']);
	$option = array_pop($keys);
        $USER->setPreference('search_engine',$option,true);
	$smarty->assign('optset',true);
} else {
	$option = $USER->getPreference('search_engine','of.php',true);
}

$smarty->assign('option',$option);


$smarty->display($template);
