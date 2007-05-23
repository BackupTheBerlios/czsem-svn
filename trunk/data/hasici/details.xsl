<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
	 <xsl:apply-templates select="rss/channel/item"/>
</xsl:template>


<xsl:template match="item">
<xsl:text>
</xsl:text> 

<xsl:value-of select="link"/>
</xsl:template>


</xsl:stylesheet>