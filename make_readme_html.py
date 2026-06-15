#!/usr/bin/env python3
"""
Convert README.md to a self-contained, styled HTML file.
Output: UniversityNews_README.html (same directory)
"""
import markdown
import os

BASE = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(BASE, "README.md"), "r", encoding="utf-8") as f:
    md_text = f.read()

# Render markdown — tables and fenced code blocks extensions
body = markdown.markdown(
    md_text,
    extensions=["tables", "fenced_code", "toc", "nl2br"]
)

CSS = """
/* ── Reset & base ── */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

body {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
               Helvetica, Arial, sans-serif;
  font-size: 16px;
  line-height: 1.7;
  color: #24292f;
  background: #ffffff;
  padding: 0 1rem 4rem;
}

.page-wrap {
  max-width: 860px;
  margin: 0 auto;
}

/* ── Header banner ── */
.site-header {
  background: #011F5B;   /* Penn blue */
  color: #ffffff;
  padding: 2rem 2rem 1.6rem;
  margin: 0 -1rem 2.5rem;
  border-bottom: 4px solid #990000;  /* Penn red */
}

.site-header h1 {
  font-size: 1.5rem;
  font-weight: 700;
  letter-spacing: -0.01em;
  margin: 0;
  border: none;
}

.site-header p {
  font-size: 0.9rem;
  opacity: 0.8;
  margin: 0.3rem 0 0;
}

/* ── Headings ── */
h1, h2, h3, h4 {
  font-weight: 700;
  line-height: 1.25;
  margin: 2rem 0 0.6rem;
  color: #011F5B;
}

h1 { font-size: 1.8rem; border-bottom: 2px solid #e8e8e8; padding-bottom: 0.4rem; }
h2 { font-size: 1.35rem; border-bottom: 1px solid #e8e8e8; padding-bottom: 0.3rem; }
h3 { font-size: 1.1rem; }
h4 { font-size: 1rem; color: #444; }

/* ── Body text ── */
p { margin: 0.75rem 0; }

a { color: #0057b8; text-decoration: none; }
a:hover { text-decoration: underline; }

/* ── Tables ── */
table {
  width: 100%;
  border-collapse: collapse;
  margin: 1.2rem 0;
  font-size: 0.92rem;
}

thead tr { background: #011F5B; color: #ffffff; }
thead th { padding: 0.55rem 0.9rem; text-align: left; font-weight: 600; }
tbody tr { border-bottom: 1px solid #e0e0e0; }
tbody tr:last-child { border-bottom: none; }
tbody tr:nth-child(even) { background: #f6f8fa; }
td { padding: 0.5rem 0.9rem; vertical-align: top; }

/* ── Code ── */
code {
  font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, monospace;
  font-size: 0.85em;
  background: #f0f0f0;
  padding: 0.15em 0.35em;
  border-radius: 3px;
}

pre {
  background: #f6f8fa;
  border: 1px solid #e0e0e0;
  border-radius: 6px;
  padding: 1rem;
  overflow-x: auto;
  margin: 1rem 0;
}

pre code { background: none; padding: 0; font-size: 0.88rem; }

/* ── Lists ── */
ul, ol { margin: 0.5rem 0 0.5rem 1.6rem; }
li { margin: 0.2rem 0; }

/* ── Horizontal rule ── */
hr { border: none; border-top: 1px solid #e0e0e0; margin: 2rem 0; }

/* ── Blockquote ── */
blockquote {
  border-left: 4px solid #990000;
  margin: 1rem 0;
  padding: 0.5rem 1rem;
  color: #555;
  background: #fafafa;
}

/* ── Footer ── */
.site-footer {
  margin-top: 3rem;
  padding-top: 1rem;
  border-top: 1px solid #e0e0e0;
  font-size: 0.82rem;
  color: #888;
  text-align: center;
}
"""

HTML = f"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>University &amp; Climate News — Project Overview</title>
  <style>
{CSS}
  </style>
</head>
<body>
  <header class="site-header">
    <h1>University &amp; Climate News</h1>
    <p>Communication Neuroscience Lab · Annenberg School for Communication · University of Pennsylvania</p>
  </header>

  <div class="page-wrap">
    {body}
  </div>

  <footer class="site-footer">
    Communication Neuroscience Lab, Annenberg School for Communication, University of Pennsylvania
  </footer>
</body>
</html>
"""

out = os.path.join(BASE, "UniversityNews_README.html")
with open(out, "w", encoding="utf-8") as f:
    f.write(HTML)

print(f"Saved: {out}")
