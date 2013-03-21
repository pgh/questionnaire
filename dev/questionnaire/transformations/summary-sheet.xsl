<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:t="http://ghadir.de/definitions/questionnaire" xmlns:s="http://ghadir.de/definitions/questionnaire/summary"
	version="2.0">
	<xsl:output method="text" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/t:questions">
		<xsl:call-template name="header" />
		<xsl:text>Gesamt:&#xa;</xsl:text>
		<xsl:call-template name="entry">
			<xsl:with-param name="type" select="'Alle'" />
			<xsl:with-param name="question-list" select="t:question"/>
		</xsl:call-template>
		<xsl:call-template name="questions_by_kind">
			<xsl:with-param name="context-group" select="t:question"/>
		</xsl:call-template>
		<xsl:text>&#xa;</xsl:text>
		<xsl:call-template name="questions_by_refers"/>
	</xsl:template>
	
	<xsl:template name="questions_by_refers">
		<xsl:for-each-group select="t:question"
			group-by="t:meta/t:refers-to">
			<xsl:value-of select="current-grouping-key()"></xsl:value-of>
			<xsl:text>:&#xa;</xsl:text>
			<xsl:call-template name="entry">
				<xsl:with-param name="type" select="'Alle'" />
				<xsl:with-param name="question-list" select="current-group()"/>
			</xsl:call-template>
			<xsl:call-template name="questions_by_kind">
				<xsl:with-param name="context-group" select="current-group()"/>
			</xsl:call-template>
			<xsl:text>&#xa;</xsl:text>
		</xsl:for-each-group>
	</xsl:template>
	
	<xsl:template name="questions_by_kind">
		<xsl:param name="context-group"/>
		<xsl:for-each-group select="$context-group" group-by="@kind">
			<xsl:variable name="detail_type" select="current-grouping-key()" />
			<xsl:call-template name="entry">
				<xsl:with-param name="type" select="$detail_type" />
				<xsl:with-param name="question-list" select="current-group()" />
			</xsl:call-template>
		</xsl:for-each-group>
	</xsl:template>

	<xsl:template name="header">
		<xsl:text>Typ, Anzahl, Punkte, Optionen&#xa;&#xa;</xsl:text>
	</xsl:template>

	<xsl:template name="entry">
		<xsl:param name="question-list"/>
		<xsl:param name="type"/>
		<xsl:variable name="number" select="count($question-list)"/>
		<xsl:variable name="points" select="sum($question-list/t:points)"/>
		<xsl:variable name="options" select="count($question-list/t:options/*)"/>
		<xsl:value-of select="$type" />
		<xsl:value-of select="', '" />
		<xsl:value-of select="$number" />
		<xsl:value-of select="', '" />
		<xsl:value-of select="$points" />
		<xsl:value-of select="', '" />
		<xsl:value-of select="$options" />
		<xsl:text>&#xa;</xsl:text>
	</xsl:template>

</xsl:stylesheet>