ReadmeDoc
=========

Inline documentation tool that aggregates @readme annotated inline-documents to README.

This tool is language diagnostic.

```objc
// HogeClass.h

/**
 *  @readme
 *
 *  This class provides awesome features.
 *
 *  /@readme
 */
@interface HogeClass
@end
```

Then following REAMDE is generated.

---

- [HogeClass](#hogeclass)

HogeClass
---

This class provides awesome features.
