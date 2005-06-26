{assign var="page_title" value="Places :: Geograph Gazetteer"}
{include file="_std_begin.tpl"}
 
    <h2>Geograph British Isles</h2>

<p>Use the links below to browse images by the village or town they are closest to.</p>

<ul>
{foreach from=$counts key=ri item=count}
<li><a href="/places/{$ri}/"><b>{$references.$ri}</b></a> [{$count} images]</li>
{/foreach}
</ul>

    
   <p style="text-align:center"><i>This page was last updated {$smarty.now|date_format:"%H:%M"}</i>.</p>

{include file="_std_end.tpl"}
