# MBCollectionView
### Custom Collection View

Basically this is a UIView subclass that reuse its cells

####The Trick:
#####You do not have to calculate heights for rows before drawing them. MBCollectionView dynamically adjusts its size as cells are drawn

######MBCollectionViewDataSource protocol header:
```
- (MBRow)rowCount;
- (MBCollectionViewCell *)collectionView:(MBCollectionView *)collectionView viewForRow:(MBRow)row;
```
