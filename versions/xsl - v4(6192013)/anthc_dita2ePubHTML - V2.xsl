<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:ds="http://www.daksys.com" exclude-result-prefixes="xs fn ds xsl">
	<xsl:output encoding="UTF-8" method="xml"/>
	<xsl:template match="topic">
		<xsl:variable name="contents">
			<html xmlns="http://www.w3.org/1999/xhtml">
				<head>
					<xsl:apply-templates select="title" mode="title"/>
					<link href="stylesheet.css" type="text/css"/>
				</head>
				<body>
				    <xsl:variable name="topic-level" select="count(preceding-sibling::topic)"/>
				    <table style="width:100%;">
					   <tbody>
					        <tr>
							 <td style="width:33%;"></td>
							 <td style="text-align:center;border-bottom:2px solid;width:33%;">
								<h1 xmlns="http://www.w3.org/1999/xhtml">
									<xsl:attribute name="style">text-align:center;font-weight:normal;text-transform:uppercase;</xsl:attribute>
									<xsl:value-of select="$topic-level+1"/>
								</h1><!--use div rather than h1-->
							 </td>
							 <td style="width:33%;"></td>
							</tr>
						 </tbody>
					</table>
				    <xsl:apply-templates/>
				</body>
			</html>
		</xsl:variable>
		<xsl:variable name="file.name" select="if(contains(@xtrf,'#'))then(replace(replace(substring-before(@xtrf,'#'),'.*/',''),'xml','xhtml'))else(replace(replace(@xtrf,'.*/',''),'xml','xhtml'))"/>
		<xsl:call-template name="write.html.file">
			<xsl:with-param name="file.name" select="concat('OEBPS/',$file.name)"/>
			<xsl:with-param name="content" select="$contents"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="title-meta">
		<!--h1 xmlns="http://www.w3.org/1999/xhtml"--><xsl:apply-templates/><!--/h1-->
	</xsl:template>
	<xsl:template match="title">
	<xsl:choose>
		<xsl:when test="parent::chapter|parent::appendix">
			<h1 xmlns="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="style">text-align:center;font-weight:normal;text-transform:uppercase;</xsl:attribute>
			<xsl:call-template name="echo.id"/>		
			<xsl:apply-templates/>
			</h1>
		</xsl:when>
		<xsl:when test="parent::sect1">
			<h2 xmlns="http://www.w3.org/1999/xhtml">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
			</h2>
		</xsl:when>
		<xsl:when test="parent::sect2|parent::sect3|parent::sect4">
			<h3 xmlns="http://www.w3.org/1999/xhtml">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
			</h3>
		</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="title" mode="title">
		<title xmlns="http://www.w3.org/1999/xhtml">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</title>
	</xsl:template>
	<xsl:template match="ALAdocument">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="chapter">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="appendix">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="sect1">
		<div xmlns="http://www.w3.org/1999/xhtml" style="margin-left:50px;">
		    <xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="sect2">
		<div xmlns="http://www.w3.org/1999/xhtml" style="margin-left:50px;">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="sect3">
		<div xmlns="http://www.w3.org/1999/xhtml"  style="margin-left:50px;">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="sect4">
		<div xmlns="http://www.w3.org/1999/xhtml" style="margin-left:50px;">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="para">
		<p xmlns="http://www.w3.org/1999/xhtml">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="emphasis">
	<xsl:choose>
		<xsl:when test="@role='italic'">
		<i xmlns="http://www.w3.org/1999/xhtml">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</i>
		</xsl:when>
		<xsl:when test="@role='operator'">
		<strong xmlns="http://www.w3.org/1999/xhtml">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</strong>
		</xsl:when>
		<xsl:otherwise>
		    <xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:template>
	<xsl:template match="b">
   </xsl:template>
	<xsl:template match="i">
	</xsl:template>
	<xsl:template match="u">
		<span xmlns="http://www.w3.org/1999/xhtml" style="text-decoration:underline">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="sup">
		<sup xmlns="http://www.w3.org/1999/xhtml">
			<xsl:apply-templates/>
		</sup>
	</xsl:template>
	<xsl:template match="sub">
		<sub xmlns="http://www.w3.org/1999/xhtml">
			<xsl:apply-templates/>
		</sub>
	</xsl:template>
	<xsl:template match="tt">
		<span xmlns="http://www.w3.org/1999/xhtml">
			<xsl:call-template name="echo.id"/>
			<xsl:attribute name="style"><xsl:value-of select="string('color:#007AAF;')"/></xsl:attribute>
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="ph">
		<span xmlns="http://www.w3.org/1999/xhtml">
			<xsl:call-template name="echo.id"/>
			<xsl:if test="@outputclass='small'">
				<xsl:attribute name="style"><xsl:value-of select="string('font-size:0.8em;')"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="unorderedlist">
		<ul xmlns="http://www.w3.org/1999/xhtml" style="margin-left:50px;">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</ul>
	</xsl:template>
	<xsl:template match="orderedlist">
		<ol xmlns="http://www.w3.org/1999/xhtml" style="margin-left:50px;">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</ol>
	</xsl:template>
	<xsl:template match="listitem">
	<xsl:variable name="list-level">
      <xsl:value-of select="count(ancestor-or-self::orderedlist)"/>	
	</xsl:variable>
	<li xmlns="http://www.w3.org/1999/xhtml">
	<xsl:call-template name="echo.id"/>
	 <xsl:choose>
		<xsl:when test="parent::orderedlist">
			 <xsl:choose>
				<xsl:when test="($list-level mod 3=1)">
				   <xsl:attribute name="style">list-style-type:lower-alpha;</xsl:attribute>			
				</xsl:when>
				<xsl:when test="($list-level mod 3=2)">
				   <xsl:attribute name="style">list-style-type:lower-roman;</xsl:attribute>			
				</xsl:when>
				<xsl:otherwise>
				   <xsl:attribute name="style">list-style-type:lower-alpha;</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:when test="parent::unorderedlist">
			 <xsl:choose>
				<xsl:when test="($list-level mod 3=1)">
				   <xsl:attribute name="style">list-style-type:circle;</xsl:attribute>			
				</xsl:when>
				<xsl:when test="($list-level mod 3=2)">
				   <xsl:attribute name="style">list-style-type:square;</xsl:attribute>			
				</xsl:when>
				<xsl:otherwise>
				   <xsl:attribute name="style">list-style-type:circle;</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
		     <xsl:choose>
				<xsl:when test="($list-level mod 3=1)">
				   <xsl:attribute name="style">list-style-type:lower-alpha;</xsl:attribute>			
				</xsl:when>
				<xsl:when test="($list-level mod 3=2)">
				   <xsl:attribute name="style">list-style-type:lower-roman;</xsl:attribute>			
				</xsl:when>
				<xsl:otherwise>
				   <xsl:attribute name="style">list-style-type:lower-alpha;</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
	<div style="padding-left:1em;display:block;">
	<xsl:apply-templates/>
	</div>
	 </li>
	</xsl:template>
   
   <xsl:template match="Exampleset">
   <div style="background-color:#d6decd">
   <xsl:call-template name="echo.id"/>
   <xsl:apply-templates/>
   </div>
   </xsl:template>	
   
   <xsl:template match="Exampleentry">
   <div xmlns="http://www.w3.org/1999/xhtml">
   <xsl:apply-templates/>
   </div>
   </xsl:template>
   
   <xsl:template match="simplesect">
   <xsl:apply-templates/>
   </xsl:template>

	<xsl:template match="mref">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="table">
		<table xmlns="http://www.w3.org/1999/xhtml">
			<xsl:if test="@frame='none'">
				<xsl:attribute name="class">noFrame</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	<xsl:template match="thead">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tgroup">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tbody">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="row">
		<tr xmlns="http://www.w3.org/1999/xhtml">
			<xsl:call-template name="echo.id"/>
			<xsl:apply-templates/>
		</tr>
	</xsl:template>
	<xsl:template match="entry[../parent::tbody]">
		<td xmlns="http://www.w3.org/1999/xhtml">
			<xsl:call-template name="echo.id"/>
			<xsl:choose>
				<xsl:when test="@align and @valign">
					<xsl:attribute name="style"><xsl:value-of select="concat('text-align:',@align,';vertical-align:',@valign)"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="@align">
					<xsl:attribute name="style"><xsl:value-of select="concat('text-align:',@align)"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="@valign">
					<xsl:attribute name="style"><xsl:value-of select="concat('vertical-align:',@valign)"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
			<xsl:if test="ancestor::table[1][@outputclass='banner']">
				<xsl:attribute name="class"><xsl:value-of select="string('banner')"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@namest">
				<xsl:variable name="namest" select="normalize-space(@namest)"/>
				<xsl:variable name="nameend" select="normalize-space(@nameend)"/>
				<xsl:attribute name="colspan"><xsl:value-of select="count(../../../colspec[normalize-space(@colname)=$nameend]/preceding-sibling::colspec) - count(../../../colspec[normalize-space(@colname)=$namest]/preceding-sibling::colspec) + 1"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@morerows">
				<xsl:attribute name="rowspan"><xsl:value-of select="number(normalize-space(@morerows))+1"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</td>
	</xsl:template>
	<xsl:template match="entry[../parent::thead]">
		<th xmlns="http://www.w3.org/1999/xhtml">
			<xsl:call-template name="echo.id"/>
			<xsl:choose>
				<xsl:when test="@align and @valign">
					<xsl:attribute name="style"><xsl:value-of select="concat('text-align:',@align,';vertical-align:',@valign)"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="@align">
					<xsl:attribute name="style"><xsl:value-of select="concat('text-align:',@align)"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="@valign">
					<xsl:attribute name="style"><xsl:value-of select="concat('vertical-align:',@valign)"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
			<xsl:if test="@namest">
				<xsl:variable name="namest" select="normalize-space(@namest)"/>
				<xsl:variable name="nameend" select="normalize-space(@nameend)"/>
				<xsl:attribute name="colspan"><xsl:value-of select="count(../../../colspec[normalize-space(@colname)=$nameend]/preceding-sibling::colspec) - count(../../../colspec[normalize-space(@colname)=$namest]/preceding-sibling::colspec) + 1"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@morerows">
				<xsl:attribute name="rowspan"><xsl:value-of select="number(normalize-space(@morerows))+1"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</th>
	</xsl:template>
	<xsl:template match="xref">
		<xsl:variable name="target" select="replace(@href,'.*/','')"/>
		<xsl:variable name="html.target" select="replace($target,'\.xml','.xhtml')"/>
		<a  xmlns="http://www.w3.org/1999/xhtml" href="{$html.target}" style="text:decoration:none">
			<xsl:call-template name="echo.id"/>
			<img src="images/magnifying_glass.jpg" alt="Link"/>
		</a>
	</xsl:template>
	<xsl:template match="image">
		<xsl:variable name="image.path">
			<xsl:choose>
				<xsl:when test="contains(@href,'/')">
					<xsl:value-of select="concat('images/',replace(@href,'.*/',''))"/>
				</xsl:when>
				<xsl:when test="contains(@href,'\')">
					<xsl:value-of select="concat('images/',replace(@href,'.*\\',''))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('images/',@href)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<img xmlns="http://www.w3.org/1999/xhtml" src="{$image.path}" alt="Image"/>
	</xsl:template>
	<xsl:template match="fig">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="note">
		<xsl:variable name="note.word">
			<xsl:choose>
				<xsl:when test="@type = 'caution'">Caution</xsl:when>
				<xsl:when test="@type = 'other' and lower-case(@othertype)='warning'">Warning</xsl:when>
				<xsl:otherwise>Note</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<div xmlns="http://www.w3.org/1999/xhtml"><xsl:value-of select="$note.word"/>: <xsl:apply-templates/></div>
	</xsl:template>
	<xsl:template match="indexterm"/>
	<xsl:template match="draft-comment"/>
	<xsl:template match="prolog|shortdesc|searchtitle|titlealts"/>
	<xsl:template match="colspec"/>
	<xsl:template match="*">
		<!--<xsl:copy-of select="."/>-->
	</xsl:template>
</xsl:stylesheet>
