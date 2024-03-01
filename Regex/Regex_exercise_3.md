# Alyssa Hopple
## Regex Exercise 3

I always look for special characters like "&" first when starting a Regex file. First, on the find window, I wrote:
```
&
```
And on the Replace Window, I wrote:
```
&amp;
```

Next, to wrap every paragraph, on the "Find" window, I wrote:
```
^.+?$
```

And then, on the "Replace" window, I wrote:
```
<p>.+?</p>
```

Next, I wrapped the "p" elements with Chapter names into heading elements. Here, on the "Find"
window, I wrote:
```
<p>\s*(CHAPTER.+?)</p>
```
And then, on the "Replace" window, I transformed these elements with:
```
<heading>\1</heading>
```

And then, I wrapped the entire chapter, including its heading, into distinct "chapter" elements.
Here, on the "Find" window, I first wrote down:
```
<heading>.+?</heading>
```
Next, I wrapped them all with this code on the "Replace" window:
```
</chapter><chapter>
```

However, I got an error after saving this into XML as I have found unnecessary placements of
the "chapter" elements, so I manually deleted them before continuing to write Regex
expressions. The last thing that I did was to wrap quotations within the story. Here, on the
"Find" window, I wrote this code:

```
[,.!?]\s+"(.+?)"
```
And the last thing I did was to write this code on the "Replace" window:

```
<q>\1</q>
```

Though I got an error where there is an unecessary placement of a "q" element, I manually
tinkered with where that element should be placed before completing this assignment altogether.