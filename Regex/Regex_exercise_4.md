# Alyssa Hopple
## Regex Exercise 4

This Regex assignment is complex as I must use a different Find/Replace window to modify
multiple files simultaneously via Regex.

First, I modified the Doctype HTML elements so I can remove the !DOCTYPE element later into the assignment.
On the Find slot, I wrote this expression:

```
(<!doctype html>\n*)?(</?)ht(ml>)
```
And then, on the Replace slot, I wrote this:

```
\2x\3
```

The next thing I did was to change elements where music notes are present into an entirely new line
without music notes. However, I did this in multiple ways as music notes appear in different places
in some lines. Some of the following codes I wrote below are on the Find slot after turning off
"Dot matches all":

```
<i>♪(.+?)♪</i>
```

```
<i>♪(.+?)</i>
```

```
<i>(.+?)♪</i>
```

For the three codes above, on the Replace slot, I wrote this same code:
```
<singing>\1</singing>
```
The next thing I did was to remove all contents between the XML and title elements after turning
"Dot matches all" back on. On the
Find slot, I wrote:
```
(<xml>).+?(<title>)
```
And on the Replace slot, I wrote this code:
```
\1\2
```

Using that same code on the Replace slot above, I would go on to remove the contents between
the title and body elements. I tinkered with the previous code to come up with this:
```
(</title>).+?(<body>)
```
It also removed the first article element, so I will show you how I wrote the code for this later.
Then, I removed some more HTML-related contents by writing down this code on the Find slot:
```
(<body>).+?</h1>
```
On the Replace slot, I wrote:
```
\1
```
After realizing that the closing tag to the article element is not removed yet, I wrote down a
simple code only on the Find slot as I left the Replace slot blank, completely removing this tag:
```
</article>
```
Next, I modified bracketed lines and turned them into action elements as they all feature
directions or verbs that are related to sound, such as "belches", "laughs", or "neighs".
On the Find slot, I wrote:
```
\[(.+?)\]
```
And on the Replace slot, I wrote:
```
<action>\1</action>
```

The last thing I did on the Regex window is to remove the doctype element, and I only worked with
the Find slot, leaving the Replace slot blank like earlier. Here, I wrote only this:
```
<!doctype html>
```
I also think that the an8 and href elements are pretty helpful for the HTML itself so I can refer to where these lines or subtitles happen, so I decided
to keep them.
On Git Bash, after locating to my BOJACK HORSEMAN directory I manually copied and pasted from
your directory, I wrote this code down, turning all HTML files into XML files:

```
for f in *.html; do mv $f `basename $f .html`.xml; done;
```
All the HTML files are now XML files! And this is where I git pushed the entire directory...
and this markdown file.