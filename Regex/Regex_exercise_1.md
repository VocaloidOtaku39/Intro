# Alyssa Hopple
## Regex Exercise 1
### Note: For each code, they are written in the "Find" window first, then the "Replace" window, respectively.

After downloading your movie data txt from GitHub, I replaced the "&" symbols. In the code below,
I wrote this on the "Find" window:

```
&
```
I then replaced every "&" symbol with this:

```
&amp;
```

Next, wrapped every line around into a &lt;movie/&gt; element. I found all lines with:

```
^.+
```

Then, I wrapped them with this:

```
<movie>\0</movie>
```

After I wrapped every line with the "movie" element, I would go on to use capturing units to
retain said element, but I am only wrapping the title name with the "title" element with these codes:

```
(<movie>)(.+?)\t
```
```
\1<title>\2</title>
```

Then, I tinkered with the previous code to wrap the release year next. In the first capturing group,
I replaced the word "movie" in the element inside the capturing group with "/title" because
the release year comes after the end of the "title" element. At this time I wrote:
```
(</title>)(.+?)\t
```
```
\1<year>\2</year>
```

I did the same tinkering with the next element, which is where each movie's companies were based:

```
(</year)(.+?)\t
```
```
\1<country>\2</country>
```

I was then presented with a challenge on how I would wrap the rest of the data within the
"movie" element. The only difference in the "Find" window, unlike every other code I made to
wrap each form of data in its own unique element is that I removed the "\t" part as there are
no tabs anymore. Instead, I wrote:

```
(</country>)(.+n\b)
```
The last capturing group means that it must capture every character until it finds a word that
ends with the letter "n", which is "min". In the replace window, I wrote this code:

```
\1<runTime>\2</runTime>
```

The next few lines of code were written manually rather than using Regex when I learned how to
replace the "&" symbols earlier. First, I added the attribute and value to the "runTime" element
to indicate the unit of time for each movie, which are in minutes. In the "Find" and "Replace"
windows I wrote the following in their respective places:

```
<runTime>
```
```
<runTime unit="min">
```

And then, I removed the word "min" from inside the "runTime" element. It was a little hard for
me to figure it out until I found a little trick I did. After writing this code on the "Find" window:

```
[spacebar]min</runTime>
```

Yes, I used the space bar before writing "min" in the code above. I then removed these characters with this
code in the "Replace" window:

```
</runTime>
```

Lastly, I manually added the &lt;xml/&gt; elements at the beginning and end of the file to wrap
it all into a root element, and I saved the file as an XML document. I performed the finishing
touch to the XML document by pressing the so-called "pretty-print" button, and the movie data
is now organized and well-formatted.