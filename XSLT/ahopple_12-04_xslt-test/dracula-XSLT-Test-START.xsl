<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes"/>
<!-- **************************************************************************-->
<!-- 2023-11-27 ebb: This XSLT starter file is for the XPath/XSLT test in DIGIT 110. 
        
    CAUTION: Do NOT alter the stylesheet root element or the output line. (The source XML is not in a namespace, 
    so this stylesheet is designed to simply read non-namespaced input and output the HTML namespace.) 
    
   Your task is to transform the source XML document of Bram Stoker's novel Dracula into HTML with a 
   table of contents linked to a reading view, and styled with CSS. Your XSLT code needs to 
   * process one source XML file and output one valid and well-formed HTML file;
   * contain an HTML table  for the table of contents that features:
        * each chapter heading
        * each chapter's distinct sorted locations;
        * each chapter's distinct sorted technologies;
        
   * contain HTML <span> elements with @class attributes in the reading view to stylize the locations and technologies mentioned. 
   * contain internal links from the chapter headings in the table of contents down to the chapter headings in the reading view (using modal XSLT);
   * Prepare CSS to style your HTML. The XSLT should output the CSS link line to your CSS file accurately. 
   * Good luck! You can (and should!) use past homeworks and examples and videos from class to help as needed. 
   * This is a solo exam, so the test contents must be your own individual work. As always, partial credit applies, so complete as much of this as you can, and 
   write XML comments as needed to explain what you're trying to do if something isn't working. 
   
    -->  
    <!-- **************************************************************************-->
  
 <xsl:template match="/">
     <html>
         <head>
             <title>Dracula</title>
             <link rel="stylesheet" type="text/css" href="style.css"/>
         </head>
         <body>
             <h1 id="top"><xsl:apply-templates select="//title"/></h1>
             
             <!-- Table of contents. -->
             <section id="contents"> 
                 <table> 
                 <tr>
                     <th>Chapter Number</th>
                     <th>Locations mentioned</th>
                     <th>Tech mentioned</th>
                 </tr>
                     
            <!-- ebb: Prepare the table of contents representing each descendant chapter heading,
                   Hint: use <xsl:apply-templates with @mode here.  -->   
          <xsl:apply-templates select=".//chapter" mode="toc"/>
             </table>
             </section>
             
             <!--Reading view of the chapters here. -->
             <section id="readingView">
                 <xsl:apply-templates select=".//chapter"/>
                <!-- ebb: Process the same descendant chapter heading elements here, but this time to start processing the reading view.  -->
             </section>
        </body>
        
     </html>
 </xsl:template>
    
   <!--ebb: Continue writing template rules, some with @mode for the table of contents, and some without it for the reading view.  -->
    <!--TABLE OF CONTENTS TEMPLATES-->
    <xsl:template match="chapter" mode="toc">
        <tr>
            <td><a href="#c-{count(preceding::chapter) + 1}"><xsl:apply-templates select="heading"/></a></td>
            <td>Locations in this chapter: <xsl:value-of select=".//location ! normalize-space() ! tokenize(., '\W')[1] => distinct-values() => sort() => string-join(', ')"/></td>
            <td>Technology in this chapter: <xsl:value-of select=".//tech ! normalize-space() ! tokenize(., '\W')[1] => distinct-values() => sort() => string-join(', ')"/></td>
        </tr>
    </xsl:template>
    
    
    <!--READING VIEW TEMPLATES-->
    
    <xsl:template match="chapter">
        <div class="chapter" id="c-{count(preceding::chapter) + 1}">
            
            <xsl:apply-templates/>
            
        </div>
    </xsl:template>
    <xsl:template match="heading">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="location">
        <span class="location">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tech">
        <span class="tech">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="date">
        <span class="date">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="time">
        <span class="time">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>