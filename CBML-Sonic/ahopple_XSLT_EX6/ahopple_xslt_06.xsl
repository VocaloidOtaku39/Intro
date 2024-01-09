<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
   
   <xsl:template match="/">
       <html>
           <head>
               <title>A New CBML Transformation!</title>
               <link rel="stylesheet" type="text/css" href="style.css"/> 
           </head>
           <body>
         
               <h1><xsl:apply-templates select="descendant::titleStmt/title"/></h1> 
               <div id="table">
                   <xsl:variable name="docTree" as="document-node()" select="current()"/>
                   <xsl:variable name="myData" as="item()+" select=".//cbml:panel/@characters ! normalize-space() ! 
                       tokenize(., ' ') => distinct-values() => sort()"/>
                   <table>
                       <tr>
                           <th>
                               Cast of Characters
                           </th>
                           <th>
                               Pages and Links to their Panels
                           </th>
                       </tr>
                       <xsl:for-each select="$myData"> 
                           
                           <tr>
                               
                               <td><xsl:value-of select="current()"/></td>
                               <td>
                                   <ul>
                                       <xsl:apply-templates select="$docTree//div[@type='page' and cbml:panel[contains(@characters, current()) ]]" mode="toc"/>
                                   </ul>
                               </td>
                           </tr>
                           
                           
                       </xsl:for-each>
                   </table>
               </div>

          <div id="characterTable">
           
              <!-- We're going to need this in the panel lookup! -->
              
              <!-- TBD:  XSLT to find the characters by page or panel here. -->
 
      
          </div>     
 
          <div id="reading-view">        
            <!-- READING VIEW PROCESSING STARTS HERE. -->
            <xsl:apply-templates select="descendant::body"/>
          </div>
   
           </body>
       </html>
   </xsl:template>
    
    <xsl:template match="div[@type='page']" mode="toc">
        
        <li>Page <xsl:value-of select="@xml:id ! substring-after(., '_')"/>
            
            <ul>
                <xsl:apply-templates select="descendant::cbml:panel" mode="toc"/>
            </ul>   
        </li>
    </xsl:template>

<xsl:template match="cbml:panel" mode="toc">
    <li>
        <a href="#{parent::div/@xml:id}-panel-{@n}">Panel <xsl:value-of select="@n"/></a>
    </li>
</xsl:template>
    
    <xsl:template match="div[@type='page']">
        <section class="{@type}" id="{@xml:id}">
            <p>
                <xsl:apply-templates select="descendant::cbml:panel | p"/>
            </p>
            <!-- ebb: Let's output some elements with @id attributes on HTML elements
                that can serve as targets for internal links.  -->
     
        </section>
    </xsl:template>
    
    <xsl:template match="cbml:balloon">
        <br/>
        <p>
            <xsl:value-of select="@who ! substring-after(.,'#') ! upper-case(.)"/>: <xsl:apply-templates select="text()"/>
        </p>
    </xsl:template>
  
  <xsl:template match="note[@type='panelDesc']">
     <br/>
      <i>
          <xsl:apply-templates/>
      </i>
  </xsl:template>
    
    <xsl:template match="cbml:caption">
       <strong><xsl:apply-templates/></strong>
    </xsl:template>
  
   <!--ebb: Most <figure> and <figdesc> elements from CBML  can be handled with the HTML <figure> element,
       which is a top-level block HTML element (not allowed inside an HTML <p>).
       
       But in the Sonic XML files there are some figure and figDescs coded inside <p> elements, so 
       if we processed all of them this way, the HTML output will have errors and not be valid HTML. 
       I'm using an XPath predicate filter to exclude the figDesc and figure elements that are housed inside <p> elements from
   processing as <figure> and <p> for this project. 
   -->

    <xsl:template match="figure[not(parent::p)]">
        <figure class="{@type}">
            <xsl:apply-templates/>
            
        </figure>
  
    </xsl:template>
    
    <xsl:template match="p | figDesc[not(ancestor::p)]">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="sound">
        <strong><span class="sound">
            <xsl:apply-templates/>
        </span></strong>
    </xsl:template>
    
    <xsl:template match="cbml:panel">
        <div class="panel" id="{parent::div/@xml:id}-panel-{@n}">
          <xsl:apply-templates/>  
        </div>
    </xsl:template>
   
    
</xsl:stylesheet>