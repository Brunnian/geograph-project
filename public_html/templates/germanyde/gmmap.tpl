{if $inner}
{assign var="page_title" value="Grid Ref Finder"}

{include file="_basic_begin.tpl"}
{else}

{assign var="page_title" value="Grid Ref Finder"}
{include file="_std_begin.tpl"}
{/if}

<script type="text/javascript" src="{"/mapper/geotools2.js"|revision}"></script>
<script type="text/javascript" src="{"/mappingG.js"|revision}"></script>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key={$google_maps_api_key}" type="text/javascript"></script>
{literal}
	<script type="text/javascript">
	//<![CDATA[
		var issubmit = 1;
		var ri = -1;
		
		//the google map object
		var map;

		//the geocoder object
		var geocoder;
		var running = false;

		function showAddress(address) {
			if (!geocoder) {
				 geocoder = new GClientGeocoder();
			}
			if (geocoder) {
				geocoder.getLatLng(address,function(point) {
					if (!point) {
						alert("Your entry '" + address + "' could not be geocoded, please try again");
					} else {
						if (currentelement) {
							currentelement.setPoint(point);
							GEvent.trigger(currentelement,'drag');

						} else {
							currentelement = createMarker(point,null);
							map.addOverlay(currentelement);

							GEvent.trigger(currentelement,'drag');
						}
						map.setCenter(point, 12);
					}
				 });
			}
			return false;
		}

		function GetTileUrl_GeoM(txy, z) {
			return "/tile.php?x="+txy.x+"&y="+txy.y+"&Z="+z;
		}
		function GetTileUrl_GeoMO(txy, z) {
			return "/tile.php?x="+txy.x+"&y="+txy.y+"&Z="+z+"&l=2&o=1";
		}
		function GetTileUrl_GeoMG(txy, z) {
			return "/tile.php?x="+txy.x+"&y="+txy.y+"&Z="+z+"&l=4&o=1";
			//return "/tile.php?x="+txy.x+"&y="+txy.y+"&Z="+z+"&l=4";
		}

		function GetTileUrl_Mapnik(a, z) {
		    return "http://tile.openstreetmap.org/" +
				z + "/" + a.x + "/" + a.y + ".png";
		}


		function GetTileUrl_TaH(a, z) {
		    return "http://tah.openstreetmap.org/Tiles/tile/" +
				z + "/" + a.x + "/" + a.y + ".png";
		}

		function GetTileUrl_TopB(a, z) {
		    //return "http://topo.openstreetmap.de/base/" +
		    return "http://base.wanderreitkarte.de/base/" +
				z + "/" + a.x + "/" + a.y + ".png";
		}

		function GetTileUrl_TopH(a, z) {
		    //return "http://hills-nc.openstreetmap.de/" +
		    return "http://wanderreitkarte.de/hills/" +
				z + "/" + a.x + "/" + a.y + ".png";
		}

		function GetTileUrl_Top(a, z) {
		    //return "http://topo.openstreetmap.de/topo/" +
		    return "http://topo.wanderreitkarte.de/topo/" +
				z + "/" + a.x + "/" + a.y + ".png";
		}

		function loadmap() {
			if (GBrowserIsCompatible()) {
				var copyright = new GCopyright(1,
					new GLatLngBounds(new GLatLng(-90,-180), new GLatLng(90,180)), 0,
					'(<a rel="license" href="http://creativecommons.org/licenses/by-sa/2.0/">CC</a>)');
				var copyrightCollection =
					new GCopyrightCollection('&copy; <a href="http://geo.hlipp.de">Geograph</a> and <a href="http://www.openstreetmap.org/">OSM</a> Contributors');
				copyrightCollection.addCopyright(copyright);
				var tilelayers = [new GTileLayer(copyrightCollection,4,13)];
				tilelayers[0].getTileUrl = GetTileUrl_GeoM;
				tilelayers[0].isPng = function () { return true; };
				tilelayers[0].getOpacity = function () { return 1.0; };
				var proj = new GMercatorProjection(19);
				var geomapm = new GMapType(tilelayers, proj, "Geo", {tileSize: 256});

				var copyright1 = new GCopyright(1,
					new GLatLngBounds(new GLatLng(-90,-180), new GLatLng(90,180)), 0,
					': http://topo.openstreetmap.de/static/licence_de.html');
				var copyright2 = new GCopyright(1,
					new GLatLngBounds(new GLatLng(-90,-180), new GLatLng(90,180)), 0,
					': http://topo.openstreetmap.de/static/licence_de.html');
				var copyright3 = new GCopyright(1,
					new GLatLngBounds(new GLatLng(-90,-180), new GLatLng(90,180)), 0,
					': http://creativecommons.org/licenses/by-sa/2.0/');
				var copyrightCollectionTopo = new GCopyrightCollection('&copy; OSM (CC)');
				var copyrightCollectionTopoH = new GCopyrightCollection('H&ouml;hen CIAT');
				//var copyrightCollectionOG = new GCopyrightCollection();
				var copyrightCollectionO = new GCopyrightCollection('Geograph Deutschland (CC)');
				copyrightCollectionTopo.addCopyright(copyright1);
				copyrightCollectionTopoH.addCopyright(copyright2);
				//copyrightCollectionO.addCopyright(copyright);
				copyrightCollectionO.addCopyright(copyright3);
				var tilelayers_mapnikhg = new Array();
				tilelayers_mapnikhg[0] = new GTileLayer(copyrightCollectionTopo, 0, 18);
				tilelayers_mapnikhg[0].isPng = function () { return true; };
				tilelayers_mapnikhg[0].getOpacity = function () { return 1.0; };
				tilelayers_mapnikhg[0].getTileUrl = GetTileUrl_Mapnik;
				tilelayers_mapnikhg[1] = new GTileLayer(copyrightCollectionTopoH, 9, 19);
				tilelayers_mapnikhg[1].isPng = function () { return true; };
				tilelayers_mapnikhg[1].getOpacity = function () { return 1.0; };
				tilelayers_mapnikhg[1].getTileUrl = GetTileUrl_TopH;
				tilelayers_mapnikhg[2] = new GTileLayer(copyrightCollectionO,4,14);
				tilelayers_mapnikhg[2].getTileUrl = GetTileUrl_GeoMO;
				tilelayers_mapnikhg[2].isPng = function () { return true; };
				tilelayers_mapnikhg[2].getOpacity = function () { return 0.5; };
				tilelayers_mapnikhg[3] = new GTileLayer(copyrightCollectionO,4,14);
				tilelayers_mapnikhg[3].getTileUrl = GetTileUrl_GeoMG;
				tilelayers_mapnikhg[3].isPng = function () { return true; };
				tilelayers_mapnikhg[3].getOpacity = function () { return 1.0; };
				var mapnikhg_map = new GMapType(tilelayers_mapnikhg,
					proj, "OSM (Mapnik) + Profile",
					{ urlArg: 'mapnikhg', linkColor: '#000000', shortName: 'OSM+G', alt: 'OSM: Mapnik+Profile, Geo' });

				map = new GMap2(document.getElementById("map"));
				map.addMapType(G_PHYSICAL_MAP);
				map.addMapType(geomapm);
				map.addMapType(mapnikhg_map);

				G_PHYSICAL_MAP.getMinimumResolution = function () { return 4 };
				G_NORMAL_MAP.getMinimumResolution = function () { return 4 };
				G_SATELLITE_MAP.getMinimumResolution = function () { return 4 };
				G_HYBRID_MAP.getMinimumResolution = function () { return 4 };
				geomapm.getMinimumResolution = function () { return 4 };

				map.addControl(new GLargeMapControl());
				map.addControl(new GMapTypeControl(true));
				
				var point = new GLatLng(51, 10); //(54.55,-3.88);
				map.setCenter(point, 5, geomapm);

				map.enableDoubleClickZoom(); 
				map.enableContinuousZoom();
				map.enableScrollWheelZoom();
		
				GEvent.addListener(map, "click", function(marker, point) {
					if (marker) {
					} else if (currentelement) {
						currentelement.setPoint(point);
						GEvent.trigger(currentelement,'drag');
					
					} else {
						currentelement = createMarker(point,null);
						map.addOverlay(currentelement);
						
						GEvent.trigger(currentelement,'drag');
					}
				});


				AttachEvent(window,'unload',GUnload,false);

				// Add a move listener to restrict the bounds range
				GEvent.addListener(map, "move", function() {
					checkBounds();
				});

				// The allowed region which the whole map must be within
				var allowedBounds = new GLatLngBounds(new GLatLng(45,2), new GLatLng(57,18));//(new GLatLng(49.4,-11.8), new GLatLng(61.8,4.1));

				// If the map position is out of range, move it back
				function checkBounds() {
					// Perform the check and return if OK
					if (allowedBounds.contains(map.getCenter())) {
					  return;
					}
					// It`s not OK, so find the nearest allowed point and move there
					var C = map.getCenter();
					var X = C.lng();
					var Y = C.lat();

					var AmaxX = allowedBounds.getNorthEast().lng();
					var AmaxY = allowedBounds.getNorthEast().lat();
					var AminX = allowedBounds.getSouthWest().lng();
					var AminY = allowedBounds.getSouthWest().lat();

					if (X < AminX) {X = AminX;}
					if (X > AmaxX) {X = AmaxX;}
					if (Y < AminY) {Y = AminY;}
					if (Y > AmaxY) {Y = AmaxY;}

					map.setCenter(new GLatLng(Y,X));

					// This Javascript Function is based on code provided by the
					// Blackpool Community Church Javascript Team
					// http://www.commchurch.freeserve.co.uk/   
					// http://econym.googlepages.com/index.htm
				}
			}
		}

		AttachEvent(window,'load',loadmap,false);

		function updateMapMarkers() {
			updateMapMarker(document.theForm.grid_reference,false,true);
		}
		AttachEvent(window,'load',updateMapMarkers,false);
	</script>
{/literal}

<div class="interestBox" style="background-color:pink; color:black; border:2px solid red; padding:10px;">
<img src="http://{$static_host}/templates/basic/img/icon_alert.gif" alt="Alert" width="50" height="44" align="left" style="margin-right:10px\"/>
<p>
This feature is still in development. Please use with care and try to avoid high server load.
</p>
<p>
Diese Kartenansicht ist noch in einem fr�hen Entwicklungsstadium! Bitte nicht �berm��ig nutzen um zu hohe Serverlast zu vermeiden.
</p>
</div>

<p>Click on the map to create a point, pick it up and drag to move to better location...</p>

<form {if $submit2}action="/submit2.php?inner"{elseif $picasa}action="/puploader.php?inner"{else}action="/submit.php" {if $inner} target="_top"{/if}{/if}name="theForm" method="post" style="background-color:#f0f0f0;padding:5px;margin-top:0px; border:1px solid #d0d0d0;">


<div style="width:600px; text-align:center;"><label for="grid_reference"><b style="color:#0018F8">Selected Grid Reference</b></label> <input id="grid_reference" type="text" name="grid_reference" value="{dynamic}{if $grid_reference}{$grid_reference|escape:'html'}{/if}{/dynamic}" size="14" onkeyup="updateMapMarker(this,false)" onpaste="updateMapMarker(this,false)" onmouseup="updateMapMarker(this,false)" oninput="updateMapMarker(this,false)"/>

<input type="submit" value="Next Step &gt; &gt;"/> <span id="dist_message"></span></div>

<div id="map" style="width:600px; height:500px;border:1px solid blue">Loading map...</div>		

<input type="hidden" name="gridsquare" value=""/>
<input type="hidden" name="setpos" value=""/>

</form>
<form action="javascript:void()" onsubmit="return showAddress(this.address.value);" style="padding-top:5px">
<div style="width:600px; text-align:center;"><label for="addressInput">Enter Address: 
	<input type="text" size="50" id="addressInput" name="address" value="" />
	<input type="submit" value="Find"/><small><small><br/>
	(Powered by the Google Maps API Geocoder)</small></small>
</div>
</form>

{if $inner}
</body>
</html>
{else}
{include file="_std_end.tpl"}
{/if}