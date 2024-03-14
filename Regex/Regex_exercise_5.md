# Alyssa Hopple
## Regex Exercise 5
### ACE ATTORNEY

I decided to apply some of the codes I used from the previous assignment into a corpus of ACE ATTORNEY
transcripts that our project team made. My teammate, Reece, git pushed the corpus, and I git pulled it
and manually copied and pasted the corpus directory into my personal repo's Regex directory.

All of the transcripts are HTML files, so I used this code that I utilized in the previous Regex
assignment:

On the Find slot, I wrote this expression:

```
(<!doctype html>\n*)?(</?)ht(ml>)
```
And then, on the Replace slot, I wrote this:

```
\2x\3
```
This converted the HTML element into an XML element as I am converting the HTML files into XML like
last time. Though it only converted the end tag to HTML (&lt;/html&gt;), I decided to replace the
remaining tag, which is the !DOCTYPE HTML element, into the opening tag of the XML element.
In the Find Slot, I first copied the !DOCTYPE HTML element, or:

```
<!DOCTYPE html>
```

And I simply wrote this element on the Replace slot:

```
<xml>
```

Next, I removed excess HTML data that bogs the file down as, again, I am turning an HTML file
into an XML file. I kept the title element to denote the name of the respective episode for each
transcript, but I only worked with the Find slot to write this code to make this kind of data
disappear:

```
<html[space].+?>.+?<meta[space].+?>
```
**Note: Yes, I used the space bar in the code above because there is an attribute on both elements
I mentioned.**

Then, I worked in little steps to remove handfuls of unnecessary HTML-related data at a time.
First, I worked from the Script element to the Div elements to remove the data from these sets.
On the Find slot, I wrote this:

```
<script>.+?<div>.+?
```

I did not write anything on the Replace slot as to make these sets disappear completely.
The next step I took to remove the rest of the HTML data is a long set of Div elements that
do not have anything inside them. After these Div elements, the transcript truly begins here.
First, on the Find slot, I wrote:

```
</div><div>.+?(<p><br ?/>)
```
**Note: The transcript I used for the semester project did not have a space between "br" and "/&gt;",
so I had to include a question mark in case there is a space or not in other transcript files.**

And then, on the Replace slot, I wrote this:

```
\1
```

There is data at the end of the file that I must remove too. Using the same code above that I wrote on the
Replace slot, I wrote a different code on the Find slot:

```
<!--.+?(</xml>)
```

The transcripts are riddled with Table elements, especially in the middle of the transcript!
I wrote this code down only on the Find slot to erase these elements:

```
<table[space].+?>.+?</table>
```
**Note: Again, there are attributes in the table elements, which is why I used the space bar here.**

After all that hard work removing the excess HTML data scattered all over the files, I finally
got to work on the actual transcript. The span elements include attributes on text styling (italicized, etc.) and what
color certain words are. I decided to convert the span elements into textEffect elements.
On the Find slot, I wrote:

```
<span[space].+?>(.+?)</span>
```

And on the Replace slot, I transformed the elements like this:

```
<textEffects>\1</textEffects>
```

And then, I decided to turn the P elements into line elements. First, I wrote this on the Find
slot:

```
<p>(.+?)</p>
```

And then I changed the P elements by writing this code on the Replace slot:

```
<line>\1</line>
```

A BR element remains in some lines, so I got rid of them by working on the Find slot to remove
them without writing anything on the Replace slot:

```
<br[space]?/>
```

Sometimes, centered text appears in the transcript, so I had an idea as to make them into
caption elements that include an attribute describing how the caption is arranged.
On the Find slot, I wrote this:

```
<center>(.+?)</center>
```

And I wrote this on the Replace slot:

```
<captions aligned="center">\1</captions>
```

And the finishing touch... I cleared out extra data on the title element so only the name
of the episode appears. I only used the Find slot to write this code:

```
[space]-[space]Transcript[space]\|[space]Ace Attorney Wiki[space]\|[space]Fandom
```

Lastly, just like last time, I went to Git Bash, navigated to the corpus directory, and
then I wrote this command on the terminal:
```
for f in *.html; do mv $f `basename $f .html`.xml; done;
```

And now, all my HTML transcripts on the corpus directory are now XML files!