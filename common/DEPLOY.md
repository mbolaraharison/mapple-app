# 1.0.0

- Fix File Data (add agencyId field):
  Run this script on all environments:

```js
const query = await db.collection("fileData").get();

const promises = query.docs.map((doc) => {
  return doc.ref.update({ agencyId: null });
});

return await Promise.all(promises);
```
