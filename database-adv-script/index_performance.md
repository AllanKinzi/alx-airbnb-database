### Index Performance

#### Index Types
- B-Tree
- Hash
- Bitmap
- GIN
- GIST
- SP-GiST
- BRIN
- GIN
- GIN  

### MySQL EXPLAIN Type Values Cheat Sheet

| Type Value      | Meaning                          | Evaluation     |
|-----------------|----------------------------------|----------------|
| `ALL`           | 🚨 Full table scan               | ❌ Bad         |
| `index`         | Full index scan (better than ALL, but still not ideal) | ⚠️ Okay |
| `range`         | Range index scan                 | ✅ Good        |
| `ref`           | Uses non-unique index with matching rows | ✅ Good  |
| `eq_ref`        | Uses unique index with one match | ✅✅ Great     |
| `const` / `system` | Very fast, 1-row lookup      | ✅✅✅ Best     |


