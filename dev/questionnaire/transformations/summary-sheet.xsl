<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:t="http://ghadir.de/definitions/questionnaire" xmlns:s="http://ghadir.de/definitions/questionnaire/summary"
	version="2.0">
	<xsl:output method="text" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/t:questions">
		<xsl:call-template name="header" />
		<xsl:call-template name="entry">
			<xsl:with-param name="type" select="'total'" />
			<xsl:with-param name="number">
				<xsl:value-of select="count(t:question)" />
			</xsl:with-param>
			<xsl:with-param name="points">
				<xsl:value-of select="sum(t:question/t:points)" />
			</xsl:with-param>
			<xsl:with-param name="options">
				<xsl:value-of select="count(t:question/t:options/*)" />
			</xsl:with-param>
		</xsl:call-template>
		<xsl:text>&#xa;</xsl:text>
		<xsl:for-each-group select="t:question" group-by="@kind">
			<xsl:call-template name="entry">
				<xsl:with-param name="type" select="current-grouping-key()" />
				<xsl:with-param name="number" select="count(current-group())" />
				<xsl:with-param name="points" select="sum(current-group()/t:points)" />
				<xsl:with-param name="options"
					select="count(current-group()/t:options/*)" />
			</xsl:call-template>
			<xsl:text>&#xa;</xsl:text>
		</xsl:for-each-group>
		<xsl:text>&#xa;</xsl:text>
		<xsl:for-each-group select="."
			group-by="t:question/t:meta/t:refers-to">
			<xsl:value-of select="current-grouping-key()"></xsl:value-of>
			<xsl:text>:&#xa;</xsl:text>
			<xsl:value-of select="count(current-group())" />
			<xsl:text>&#xa;</xsl:text>
			<xsl:call-template name="test">
				<xsl:with-param name="context" select="current-group()"/>
			</xsl:call-template>
			<xsl:text>&#xa;</xsl:text>
		</xsl:for-each-group>
	</xsl:template>
	
	<xsl:template name="test">
		<xsl:param name="context"/>
		<xsl:for-each-group select="t:question" group-by="@kind">
			<xsl:value-of select="current-grouping-key()"></xsl:value-of>
			<xsl:text>:&#xa;</xsl:text>
			<xsl:value-of select="count(current-group())" />
			<xsl:text>&#xa;</xsl:text>			
		</xsl:for-each-group>
		<xsl:value-of select="$context"/>
	</xsl:template>

	<xsl:template name="header">
		<xsl:text>Typ, Anzahl, Punkte, Optionen&#xa;</xsl:text>
	</xsl:template>

	<xsl:template name="entry">
		<xsl:param name="type" />
		<xsl:param name="number" />
		<xsl:param name="points" />
		<xsl:param name="options" />
		<xsl:value-of select="$type" />
		<xsl:value-of select="', '" />
		<xsl:value-of select="$number" />
		<xsl:value-of select="', '" />
		<xsl:value-of select="$points" />
		<xsl:value-of select="', '" />
		<xsl:value-of select="$options" />
	</xsl:template>

</xsl:stylesheet>