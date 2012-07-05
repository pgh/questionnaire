<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:q="http://ghadir.de/definitions/questionnaire"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	version="2.0">


	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

		<fo:layout-master-set>
		  <fo:simple-page-master master-name="A4" page-height="297mm"
			page-width="210mm" margin-top="1cm" margin-bottom="1cm"
			margin-left="1cm" margin-right="1cm">
			  <fo:region-body margin="1cm"/>
			  <fo:region-before extent="2cm"/>
			  <fo:region-after extent="2cm"/>
			  <fo:region-start extent="2cm"/>
			  <fo:region-end extent="2cm"/>
		  </fo:simple-page-master>
		</fo:layout-master-set>

		<fo:page-sequence master-reference="A4">
		  <fo:flow flow-name="xsl-region-body">
			<xsl:apply-templates/>
		  </fo:flow>
		</fo:page-sequence>
		</fo:root>
	</xsl:template>

<!--
	<xsl:template match="question[@kind='P' or @kind='S']">
	-->
	<xsl:template match="q:question">
		<fo:block font-size="14pt" font-family="Helvetica" keep-together.within-page="always" space-before="5mm" space-after="5mm">
			<xsl:apply-templates select="./q:meta"/>
			<fo:block>
				<fo:table width="100%" table-layout="fixed">
					<fo:table-column column-width="85%"/>
					<fo:table-column column-width="15%"/>
					<fo:table-body>
						<fo:table-row border="1">
							<fo:table-cell>
								<fo:block><xsl:value-of select="./q:p"/></fo:block>
								<xsl:apply-templates select="./q:options"/>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:apply-templates select="./q:points"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
				</fo:block>
		</fo:block>
	</xsl:template>



	<xsl:template match="q:question[@kind='P']/q:options">
		<fo:block font-style="italic"><xsl:value-of select="../@kind"/>-Frage: Wählen Sie <xsl:value-of select="count(./q:correct)"/> aus den <xsl:value-of select="count(./q:distractor|./q:correct)"/> Antwortmöglichkeiten aus.</fo:block>
		
		<xsl:apply-templates select="q:*"/>
	</xsl:template>
	
	<xsl:template match="q:question[@kind='A']/q:options">
		<fo:block font-style="italic"><xsl:value-of select="../@kind"/>-Frage: Kreuzen Sie genau eine Antwortmöglichkeit an.</fo:block>
		<xsl:apply-templates select="q:*"/>
	</xsl:template>



	<xsl:template match="q:question[@kind='K']/q:options">
		<fo:block font-style="italic"><xsl:value-of select="../@kind"/>-Frage: Ordnen Sie alle Antworten zu.</fo:block>
		
		<fo:table width="100%" table-layout="fixed">
			<fo:table-column column-width="15%" max-width="20%" wrap-option="wrap"/>
			<fo:table-column column-width="15%" max-width="20%" wrap-option="wrap"/>
			<fo:table-column column-width="70%" min-width="60%"/>
			<fo:table-body>
				<fo:table-row border="1">
					<xsl:apply-templates select="../q:categories/q:category"/>
					
					<fo:table-cell><fo:block></fo:block></fo:table-cell>
				</fo:table-row>
				<xsl:apply-templates select="q:*"/>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	
	<xsl:template match="q:question[@kind='K']/q:options/q:*">
		<fo:table-row border="1">

			<fo:table-cell text-align="center"><fo:block><xsl:value-of select="name()"/></fo:block></fo:table-cell>
			<fo:table-cell><fo:block><xsl:value-of select="."/></fo:block></fo:table-cell>
		</fo:table-row>
		
	</xsl:template>
	
	<xsl:template match="q:question[@kind='K']/q:categories/q:category">
		<fo:table-cell>
			<fo:block><xsl:value-of select="."/></fo:block>
		</fo:table-cell>
	</xsl:template>
	
	<xsl:template match="q:question/q:meta">
		<fo:block font-stretch="condensed" font-style="italic" font-size="80%">
			Id: <xsl:value-of select="./q:id"/>
			Status: <xsl:value-of select="./q:status"/>
			Kapitel: <xsl:value-of select="./q:refers-to"/>
			Note: <xsl:value-of select="./q:rating"/>&#160;
			Stimmen: <xsl:value-of select="./q:votes"/>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="q:points">
		<xsl:value-of select="."/> Punkte
	</xsl:template>
	
    <xsl:template match="q:unchecked">
        unchecked!
    </xsl:template>

    <xsl:template match="q:checked">
        checked!
    </xsl:template>

	<xsl:template match="q:correct">
		<fo:block>
			<fo:character character="&#x2612;" font-family="Arial Unicode" padding-left="30" padding-right="10"/> <xsl:value-of select="."/>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="q:distractor">
		<fo:block>
			<fo:character character="&#x2610;" font-family="Arial Unicode" padding-left="30" padding-right="10"/> <xsl:value-of select="."/>
		</fo:block>
	</xsl:template>
	
</xsl:stylesheet>

