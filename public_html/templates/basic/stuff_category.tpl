{assign var="page_title" value="Category Tester"}
{include file="_std_begin.tpl"}

<h2>Category Selection Tester</h2>


 <div class="interestBox" style="margin:10px">
   <form method="get" action="{$script_name}" style="display:inline">
    <select name="type" onchange="this.form.submit()">
    	{html_options options=$types selected=$type}
    </select>
  <noscript>
    <input type="submit" value="Update"/></noscript></form></div>



    <form enctype="multipart/form-data" action="{$script_name}" method="post" name="theForm" onsubmit="if (this.imageclass) this.imageclass.disabled=false;" {if $step ne 1}style="background-color:#f0f0f0;padding:5px;margin-top:0px; border:1px solid #d0d0d0;"{/if}>

<h3>Dummy submission</h3>


{if $type eq 'top'}
<h3>Title and Comments</h3>
<p>Please provide a short title for the image, and any other comments about where
it was taken or other interesting geographical information. <span id="styleguidelink">({newwin href="/help/style" text="Open Style Guide"})</span></p>

<p><label for="title"><b>Title</b></label> {if $error.title}
	<br/><span class="formerror">{$error.title}</span>
	{/if}<br/>
<input size="50" maxlength="128" id="title" name="title" value="{$title|escape:'html'}" spellcheck="true" onblur="checkstyle(this,'title',true);" onkeyup="checkstyle(this,'title',false);"/> <span class="formerror" style="display:none" id="titlestyle">Possible style issue. See Guide above. <span id="titlestylet" style="font-size:0.9em"></span></span></p>
 {if $place.distance}
 <p style="font-size:0.7em">Gazetteer info as will appear:<br/> <span style="color:silver;">{place place=$place}</span></p>
 {/if}

<p style="clear:both"><label for="comment"><b>Description/Comment</b></label> <span class="formerror" style="display:none" id="commentstyle">Possible style issue. See Guide above. <span id="commentstylet"></span></span><br/>
<textarea id="comment" name="comment" rows="7" cols="80" spellcheck="true" onblur="checkstyle(this,'comment',true);" onkeyup="checkstyle(this,'comment',false);">{$comment|escape:'html'}</textarea></p>

<div style="font-size:0.7em">TIP: use <span style="color:blue">[[TQ7506]]</span> to link to a Grid Square or <span style="color:blue">[[54631]]</span> to link to another Image.<br/>
For a weblink just enter directly like: <span style="color:blue">http://www.example.com</span><br/><br/></div>
 
<div>
	<div style="float:right"><a href="/article/Shared-Descriptions" text="Article about Shared Descriptions" class="about" target="_blank">About</a></div>
	<b>Shared Descriptions/References (Optional)</b>
	<span id="hideshare"><input type=button onclick="show_tree('share'); document.getElementById('shareframe').src='/submit_snippet.php?upload_id={$upload_id}&gr={$grid_reference|escape:'html'}';return false;" value="Expand"/></span>
	<div id="showshare" style="display:none">
		<iframe src="about:blank" height="400" width="98%" id="shareframe" style="border:2px solid gray">
		</iframe>
		<div><a href="#" onclick="hide_tree('share');return false">- Close <i>Shared Descriptions</I></a></div>
	</div>
</div>
<br/>

<h3>Further Information</h3>
	<div style="float:right">Categories have changed! <a href="/article/Transitioning-Categories-to-Tags" text="Article about new tags and categories" class="about" target="_blank">About</a></div>

	<p><label for="top"><b>Primary geographical category</b></label><br />
		<select id="top" name="top">
			<option value="">--please select feature--</option>
			{html_options options=$tops selected=$top}

		</select> (To select additional, or to add free-from tags, open the tagging box below...)
	</p>

<h4 class="titlebar">Tags (Optional) <input type="button" value="expand" onclick="show_tree('tag'); document.getElementById('tagframe').src='/tags/tagger.php?ids=1,2';" id="hidetag"/></h4>
<div id="showtag" style="display:none">
	<ul>
		<li>Tags are a new feature on Geograph - they are still under heavy development - not fully working yet!</li>
		<li>Read more in {newwin href="/article/Tags" text="Article about Tags"}</li>
	</ul>
	<iframe src="about:blank" height="200" width="100%" id="tagframe">
	</iframe>

</div>


<p><label><b>Date photo taken</b></label> {if $error.imagetaken}
	<br/><span class="formerror">{$error.imagetaken}</span>
	{/if}<br/>
	{html_select_date prefix="imagetaken" time=$imagetaken start_year="-200" reverse_years=true day_empty="" month_empty="" year_empty="" field_order="DMY"}
	{if $imagetakenmessage}
	    {$imagetakenmessage}
	{/if}

	[ Use
	<input type="button" value="Today's" onclick="setdate('imagetaken','{$today_imagetaken}',this.form);" class="accept"/>
	{if $last_imagetaken}
		<input type="button" value="Last Submitted" onclick="setdate('imagetaken','{$last_imagetaken}',this.form);" class="accept"/>
	{/if}
	{if $imagetaken != '--' && $imagetaken != '0000-00-00'}
		<input type="button" value="Current" onclick="setdate('imagetaken','{$imagetaken}',this.form);" class="accept"/>
	{/if}
	Date ]

	<br/><br/><span style="font-size:0.7em">(please provide as much detail as possible, if you only know the year or month that's fine)</span></p>


{elseif $type eq 'autocomplete'}

	<p><label for="imageclass"><b>Primary geographical category</b></label><br />
		<input size="32" id="imageclass" name="imageclass" value="{$imageclass|escape:'html'}" maxlength="32" spellcheck="true"/>
		</p>
	{literal}
	<script type="text/javascript">
	<!--

	AttachEvent(window,'load', function() {
		var inputWord = $('imageclass');

	    new Autocompleter.Request.JSON(inputWord, '/finder/categories.json.php', {
		'postVar': 'q',
		'minLength': 2,
		maxChoices: 60
	    });

	},false);

	//-->
	</script>
	{/literal}

{else}

	{literal}
	<script type="text/javascript">
	<!--
	//rest loaded in geograph.js
	function mouseOverImageClass() {
		if (!hasloaded) {
			setTimeout("prePopulateImageclass2()",100);
		}
		hasloaded = true;
	}

	function prePopulateImageclass2() {
		var sel=document.getElementById('imageclass');
		sel.disabled = false;
		var oldText = sel.options[0].text;
		sel.options[0].text = "please wait...";

		populateImageclass();

		hasloaded = true;
		sel.options[0].text = oldText;
		if (document.getElementById('imageclass_enable_button'))
			document.getElementById('imageclass_enable_button').disabled = true;
	}

	function showDetail() {
		{/literal}{if $type eq 'canonicalplus' || $type eq 'canonicalmore'}{literal}

		var sel=document.getElementById('imageclass');

		var idx=sel.selectedIndex;

		var isOther=idx==sel.options.length-1;

		if (idx > 0 && !isOther) {

			canonical = sel.options[sel.selectedIndex].value;

			{/literal}{if $type eq 'canonicalmore'}
			url = "/finder/categories.json.php?more=1&canonical="+encodeURIComponent(canonical);
			{else}
			url = "/finder/categories.json.php?canonical="+encodeURIComponent(canonical);
			{/if}{literal}

			var req = new Request({
				method: 'get',
				url: url,
				onComplete: function(response) {
					var sel=document.getElementById('imageclass2');

					var opt=sel.options;

					//clear out the options
					for(q=opt.length;q>=0;q=q-1) {
						opt[q] = null;
					}
					opt.length = 0; //just to confirm!
					//re-add the first
					opt[0] = new Option('Optionally select a more detailed category...','');

					var optionsList = JSON.decode(response);

					if (optionsList.length == 0 || (optionsList.length == 1 && optionsList[0] == canonical)) {
						document.getElementById('detailblock').style.display='none';
						return;
					}

					//add the whole list
					for(i=0; i < optionsList.length; i++) {
						act = optionsList[i];
						if (act != canonical) {
							opt[opt.length] = new Option(act,act);
						}
					}
				}
			}).send();

			document.getElementById('detailblock').style.display='';
		} else {
			document.getElementById('detailblock').style.display='none';
		}

		{/literal}{/if}{literal}
	}

	AttachEvent(window,'load',onChangeImageclass,false);
	AttachEvent(window,'load',showDetail,false);
	//-->
	</script>
	{/literal}

	{if $type eq 'canonicalmore'}
	<p><label for="imageclass"><b>Primary geographical category</b> (Unmoderated Full Canonical List)</label><br />
	{elseif $type eq 'canonical' || $type eq 'canonicalplus'}
	<p><label for="imageclass"><b>Primary geographical category</b> (Simplified List)</label><br />
	{else}
	<p><label for="imageclass"><b>Primary geographical category</b></label><br />
	{/if}
		<select id="imageclass" name="imageclass" onchange="onChangeImageclass();showDetail()" onfocus="prePopulateImageclass()" onmouseover="mouseOverImageClass()" style="width:300px">
			<option value="">--please select feature--</option>
			{if $imageclass}
				<option value="{$imageclass}" selected="selected">{$imageclass}</option>
			{/if}
			<option value="Other">Other...</option>
		</select>

		{if $type eq 'canonicalplus' || $type eq 'canonicalmore'}
			<span id="detailblock">
				<select id="imageclass2" name="imageclass2">
					<option value="">-- please wait ... --</option>
				</select>
			</span>
		{/if}

		<span id="otherblock">
		<label for="imageclassother">Please specify </label>
		<input size="32" id="imageclassother" name="imageclassother" value="{$imageclassother|escape:'html'}" maxlength="32" spellcheck="true"/>

		{if $type eq 'canonical' || $type eq 'canonicalplus' || $type eq 'canonicalmore'}
			<br/>Note: This doesn't automatically create a new Canonical Category, rather just adds it as a normal category, it will be assigned to a canonical category via a collaborative review.
		{/if}

		</span></p>

{/if}


{if $type eq 'autocomplete'}
	<link rel="stylesheet" type="text/css" href="{"/js/Autocompleter.css"|revision}" />

	<script type="text/javascript" src="{"/js/mootools-1.2-core.js"|revision}"></script>
	<script type="text/javascript" src="{"/js/Observer.js"|revision}"></script>
	<script type="text/javascript" src="{"/js/Autocompleter.js"|revision}"></script>
	<script type="text/javascript" src="{"/js/Autocompleter.Request.js"|revision}"></script>

{elseif $type eq 'canonical' || $type eq 'canonicalplus' || $type eq 'canonicalmore'}
	<script type="text/javascript" src="/categories.js.php?canonical=1{if $type eq 'canonicalmore'}&amp;more=1{/if}"></script>
	<script type="text/javascript" src="/categories.js.php?full=1&amp;u={$user->user_id}"></script>

	{if $type eq 'canonicalplus' || $type eq 'canonicalmore'}
		<script type="text/javascript" src="{"/js/mootools-1.2-core.js"|revision}"></script>
	{/if}
{else}
	<script type="text/javascript" src="/categories.js.php"></script>
	<script type="text/javascript" src="/categories.js.php?full=1&amp;u={$user->user_id}"></script>
{/if}

</form>

{include file="_std_end.tpl"}