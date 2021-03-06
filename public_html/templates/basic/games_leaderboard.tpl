{assign var="page_title" value="Games All Time Leaderboard"}

{include file="_std_begin.tpl"}

<h2><a href="/games/">Geograph Games</a> - All Time Leaderboard</h2>

<form method="get" action="{$script_name}">
<p> <label for="g">Game</label>: <select name="g" id="g">
{html_options options=$gamelist selected=$g}
</select> <label for="l">Level:</label><select name="l" id="l">
{html_options options=$levellist selected=$l}
</select>
<input type="submit" value="Go">
	
&nbsp;&nbsp;&nbsp;&nbsp; See also <a href="/games/moversboard.php?l={$l}&amp;g={$g}">weekly leaderboard</a></p>
</form>
<hr/>

<table class="report"> 
<thead><tr><td>Position</td><td>Name</td><td>Level</td><td>Overall</td><td>Games</td><td><img src="http://{$static_host}/templates/basic/img/hamster-icon.gif"/></td></tr></thead>
<tbody>

{foreach from=$topusers key=topuser_id item=topuser}
<tr><td align="right">{$topuser.ordinal}</td><td>{if $topuser.user_id}<a title="View profile" href="/profile/{$topuser.user_id}">{$topuser.realname|escape:"html"}</a>{else}{$topuser.username|escape:"html"}{/if}</td>
<td align="right">{$topuser.level}</td>
<td align="right">{$topuser.average}</td>
<td align="right">{$topuser.games}</td>
<td align="right">{$topuser.score}</td>
</tr>
{/foreach}

</tbody>
</table>



 		
{include file="_std_end.tpl"}
