<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:t="http://ghadir.de/definitions/questionnaire"
	version="2.0">


	<xsl:template match="t:points">
		<xsl:element name="points">
			<xsl:value-of select="."/>
			<xsl:choose>
				<xsl:when test=". = '1'"> Punkt</xsl:when>
				<xsl:otherwise> Punkte</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>

	<xsl:template match="t:question[@kind='P']/t:p">
	    <xsl:copy>
	        <xsl:apply-templates select="@*|node()"/>
	    </xsl:copy>
		<xsl:element name="t:hint">
			Bitte kreuzen Sie <xsl:value-of select="count(../t:options/t:correct)"/> der <xsl:value-of select="count(../t:options/*)"/> Antworten an.
		</xsl:element>
	</xsl:template>

    <xsl:template match="t:question[@kind='K']/t:options/t:a">
        <xsl:element name="response">
            <xsl:element name="checked"/>
            <xsl:element name="unchecked"/>
            <xsl:copy>
                <xsl:apply-templates select="@*|node()"/>
            </xsl:copy>
        </xsl:element>
    </xsl:template>

    <xsl:template match="t:question[@kind='K']/t:options/t:b">
        <xsl:element name="response">
            <xsl:element name="t:unchecked"/>
            <xsl:element name="t:checked"/>
            <xsl:copy>
                <xsl:apply-templates select="@*|node()"/>
            </xsl:copy>
        </xsl:element>
    </xsl:template>

	<xsl:template match="*">
	    <xsl:copy>
	        <xsl:apply-templates select="@*|node()"/>
	    </xsl:copy>
	</xsl:template>
	<xsl:template match="@*|text()|comment()|processing-instruction()">
	    <xsl:copy-of select="."/>
	</xsl:template>
</xsl:stylesheet>

