{dynamic}

This is a multi-part message in MIME format.

------=_NextPart_000_00DF_01C5EB66.9313FF40
Content-Type: text/plain;
	charset="{$charset}"
Content-Transfer-Encoding: 8bit

--This message was sent through the {$http_host} web site--
   
{$msg}

--------------------------------

http://{$http_host}/photo/{$image->gridimage_id}

{$image->title|escape:'html'}
{$image->comment|escape:'html'}

View Online at http://{$http_host}/photo/{$image->gridimage_id}
--------------------------------
Image � Copyright {$image->realname} and licensed for reuse under this Creative Commons Licence. 
http://creativecommons.org/licenses/by-sa/2.0/
--------------------------------

This message was sent to you by site visitor to Geograph Deutschland,
forward abuse complaints to: {$contactmail}

------=_NextPart_000_00DF_01C5EB66.9313FF40
Content-Type: text/html;
	charset="{$charset}"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset={$charset}"><BASE 
href="http://{$http_host}/"\>
<META content="Geograph User: {$user->user_id}" name=GENERATOR>
</HEAD>
<BODY bgColor=#eeeeff leftMargin=0 topMargin=0 MARGINHEIGHT="0" MARGINWIDTH="0">
<TABLE cellSpacing=0 cellPadding=0 width="750" align=center style="width:750px;">
<TBODY><TR><TD>
<TABLE cellSpacing=0 cellPadding=4 width="100%">
  <TBODY>
  <TR>
    <TD bgColor=#000066>&nbsp;</TD>
    <TD bgColor=#000066><A href="http://{$http_host}/"><IMG height=74 
      src="http://{$http_host}/templates/germany32/img/logode3.gif" width=350 border=0></A></TD>
    <TD vAlign=top align=center bgColor=#000066><A 
      href="http://{$http_host}/"><FONT face=Georgia color=#ffffff 
      size=+2>{$http_host}</FONT></A><BR><FONT face=Georgia color=#ffffff><I>The Geograph Deutschland project aims to collect a geographically representative<BR> photograph for every square kilometre of Germany and you can be part of it.</I></FONT></TD>
    <TD bgColor=#000066>&nbsp;</TD></TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD COLSPAN="2" ALIGN="CENTER">
      </TD>
    <TD>&nbsp;</TD>
    </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD style="BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid" 
    vAlign=top bgColor=#ffffff><BR><FONT face=Georgia>
    {$htmlmsg}
    </FONT><BR></TD>
    <TD style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid" 
    align=middle bgColor=#ffffff><BR><A 
      href="http://{$http_host}/photo/{$image->gridimage_id}">{$image->getFull(true)|replace:'alt=':'border=0 alt='}</A></TD>
    <TD>&nbsp;</TD></TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD style="BORDER-LEFT: black 1px solid" vAlign=top 
    bgColor=#ffffff>&nbsp;</TD>
    <TD style="BORDER-RIGHT: black 1px solid" align=middle bgColor=#ffffff>
      <DIV class=caption><FONT face=Georgia size=-1><B>{$image->title|escape:'html'}</B></FONT></DIV>
      <DIV class=caption><FONT face=Georgia size=-1>{$image->comment|escape:'html'|geographlinks}</FONT></DIV></TD>
    <TD>&nbsp;</TD></TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD 
    style="BORDER-RIGHT: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid" 
    vAlign=top align=middle bgColor=#ffffff colSpan=2><FONT face=Georgia>View 
      Online at <A 
      href="http://{$http_host}/photo/{$image->gridimage_id}">http://{$http_host}/photo/{$image->gridimage_id}</A></FONT></TD>
    <TD>&nbsp;</TD></TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD vAlign=top align=middle bgColor=#dddddd colSpan=2><A 
      href="http://creativecommons.org/licenses/by-sa/2.0/"><IMG height=31 
      src="http://creativecommons.org/images/public/somerights20.gif" width=88 align=right 
      border=0></A> <FONT face=Georgia>Image &copy; Copyright <A title="View profile" 
      href="http://{$http_host}{$image->profile_link}">{$image->realname}</A> and licensed for reuse under this 
      <A class=nowrap href="http://creativecommons.org/licenses/by-sa/2.0/" 
      rel=license>Creative&nbsp;Commons&nbsp;Licence</A>.</FONT></TD>
    <TD>&nbsp;</TD></TR>
</TBODY></TABLE>
</TD></TR></TBODY></TABLE>
<P align=center><FONT face=Georgia size=-1>This message was sent to you by site 
visitor to Geograph Deutschland, <BR>forward abuse complaints to: 
{$contactmail}</FONT><!-- {$user->user_id} --></P></BODY></HTML>

------=_NextPart_000_00DF_01C5EB66.9313FF40--

{/dynamic}
