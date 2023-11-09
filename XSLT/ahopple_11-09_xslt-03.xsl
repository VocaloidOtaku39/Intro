<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    Alyssa's Take on the Skyrim Project
                </title>
                <link rel="stylesheet" type="text/css" href="skyrim.css"/>
            </head>
            <body>
                <h1>
                    Alyssa's Take on the Skyrim Project
                </h1>
                <xsl:apply-templates/>   
            </body>
        </html>

    </xsl:template>
    
    <xsl:template match="cast">
        <h2>
            Cast of Characters
        </h2>
        <ul>
            <xsl:apply-templates select="//cast/character"/>
        </ul>
        <h2>
            Plot
        </h2>
    </xsl:template>
    <xsl:template match="//cast/character">
        <li>
            <xsl:apply-templates select="@id"/>
        </li>
    </xsl:template>
    <xsl:template match="paragraph">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="location">
        <u>
            <xsl:apply-templates/>
        </u>
    </xsl:template>
    <xsl:template match="epithet">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    <xsl:template match="QuestEvent">
        <strong>
            <xsl:apply-templates/>
        </strong>
    </xsl:template>
    <xsl:template match="QuestItem">
        <span class="item">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="faction[@ref='MythicDawn']">
        <span class="mythicdawn">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="faction[@ref='blades']">
        <span class="blades">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="faction[@ref='daedra']">
        <span class="daedra">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="character">
        <span class="character">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>