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
			<xsl:with-param name="correct">
				<xsl:value-of select="count(t:question/t:options/t:correct)" />
			</xsl:with-param>
			<xsl:with-param name="categories">
				<xsl:value-of select="count(t:question[@kind='K']/t:categories/t:category)" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="header">
		<xsl:text>Typ, Anzahl, Punkte, Optionen, davon korrekt, Kategorien
		</xsl:text>
	</xsl:template>

	<xsl:template name="entry">
		<xsl:param name="type" />
		<xsl:param name="number" />
		<xsl:param name="points" />
		<xsl:param name="options" />
		<xsl:param name="correct" />
		<xsl:param name="categories" />
		<xsl:value-of select="$type" />
		<xsl:value-of select="', '"/>
		<xsl:value-of select="$number"/>
		<xsl:value-of select="', '"/>
		<xsl:value-of select="$points"/>
		<xsl:value-of select="', '"/>
		<xsl:value-of select="$options"/>
		<xsl:value-of select="', '"/>
		<xsl:value-of select="$correct"/>
		<xsl:value-of select="', '"/>
		<xsl:value-of select="$categories"/>
	</xsl:template>

	<xsl:template match="*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="@*|text()|comment()|processing-instruction()">
		<xsl:copy-of select="." />
	</xsl:template>

</xsl:stylesheet>