ReadmeDoc
=========

Inline documentation tool that aggregates @readme annotated inline-documents to README.

This tool is language diagnostic.

```objc
/**
 *  @readme
 *
 *  Title
 *  ---
 *
 *  It is foo bar.
 *
 *  /@readme
 */
@interface HogeClass
@end
```

Then following REAMDE is generated.

---

Title
---

It is foo bar.
