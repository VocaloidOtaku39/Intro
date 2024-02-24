# Alyssa Hopple
## Regex Exercise 2
### Note: For each code, they are written in the "Find" window first, then the "Replace" window, respectively.

After removing the details about the document, I left the title and release date behind so I can
work with each sonnet and their lines. First, I must remove the space before the first word of
each line. I only worked with the "Find" window for this step. Here, I wrote this code that
removes these spaces:
```
^\s\s
```

The next thing I did was to start organizing the document by wrapping things in lines, including
the sonnet number, which I got back to later into this assignment. Below are the codes I wrote
on the "Find" and "Replace" windows, respectively:

```
^.+$
```

```
<line>\0</line>
```

Then, I went to modify the sonnet number by replacing the &lt;line/&gt; elements with
&lt;sonnet/&gt; elements by writing down the following codes. On the "Find" window, I wrote:

```
<line>\s([IVXLC]+)</line>
```

And then, on the replace window, I wrote:

```
</sonnet><sonnet n="\1">
```

However, it did not modify Sonnet I's title and the very end of the entire document, so I
manually modified the data into the first sonnet's title, as well as adding "&lt;/sonnet&gt;"
at the end of the last sonnet. I also added metadata elements in the beginning of the document,
and I wrapped the entire document in an XML element.

After saving the document as an XML file, it was already well-formed when I opened it up, so
the only thing that I did was to pretty print it before saving it again.