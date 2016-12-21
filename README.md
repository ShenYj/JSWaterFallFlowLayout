# JSWaterFallFlowLayout

瀑布流[ShenYj](https://github.com/ShenYj)



>使用说明:<br>

>>  .h头文件描述 :<br>
>>> 1.`itemColCount`-> 列数,如果不指定,默认3列,滚动方向为垂直方向 <br>
>>> 2.`footerViewHeight`-> FooterView高度,如果不指定,默认为49  <br>
>>> 3.`dataSource`数据源代理对象,通过设置此代理对象,实现协议方法(必须实现),获取到图片的宽高比例,计算布局 <br>

>> 实现过程: <br>
>>> 1.在CollectionView进行布局,实现`prepareLayout`过程中,通过遍历当前CollectionView的items,将每个具体Item的attribute取出(在自定义流水布局类中,通过`[self layoutAttributesForItemAtIndexPath:indexPath]`获取到具体item的属性),存入到一个自定义的数组中(itemAttributesArr) <br>
>>> 2.自定义一个数组`tempItemAttributeArrMaxY`,初始化3个值均为0的元素(切长度限制为列数),用来记录每一列上当前元素的最大Y轴坐标,便于给该列的下一个元素计算CoordinateY值 <br>
>>> 3.在步骤1中,手动调用了`layoutAttributesForItemAtIndexPath:`,在这里不再调用super,而是手动计算每个Item的CoordinateX、CoordinateY、Width、Height,设置Frame ,并将对应列的最大Y值更新 <br>
>>> 4.在`layoutAttributesForElementsInRect`中直接返回自定义数组(itemAttributesArr,记录着手动修改Frame后的共有的属性对象)
>>> 5.在`collectionViewContentSize`方法中,重新计算CollectionView的ContentSize(`组头的高度 + 顶部的组内间距 + 最大Y值 + 底部的组内间距 + 组尾的高度`) <br>
>>> 6.CollectionView的排列方向为垂直方向,所有Item以九宫格方式依次排列,若某一列图片高度相对于其他某一列相对要高很多,会导致整体高度排列不均匀的问题 <br>
>>> 7.优化高度(优化CoordinateX、CoordinateY):定义两个属性:`currentMinY`和`currentMinYCol`,分别记录当前的最小Y值(遍历tempItemAttributeArrMaxY对比得出3列中最小的值)和当前最小Y值所在的列号,计算CoordinateX和CoordinateY值时,以及在更新`tempItemAttributeArrMaxY`时,分别在`currentMinYCol`上进行操作 <br>
>>> 8.这样瀑布流Item 的Frame、高度优化 便设置完成 <br>
>>> 9.FooterView处理: 在layout中返回可视化区域的控件是包含footer和headerView的,所以如果有的话需要单独添加;在`prepareLayout`遍历取出每个Item共有属性存入数组后,取出FooterView的属性对象(通过`[UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:footerViewIndexPath]`,头为标签的item值默认均为0,所以只需要根据对应section,设置Kind枚举值便可取出头尾标签的属性对象,而在这里我们的section只有一组,所以section为0),需要注意的是,在`prepareLayout`中,设置头尾标签Frame(x,y,w,h)都是有意义的,设置好尾标签的Frame后,同样将尾标签的属性对象存入到`itemAttributesArr`数组中  <br>
>>> 10.上拉刷新时的处理,刷新数据后会调用reloadData,会重新执行`prepareLayout`方法,再遍历CollectionView的每个Item共有属性,添加至属性对象数组,不做任何处理,会属性对象数组对象叠加(原本记录存放的属性对象 + CollectionView刷新后现有全部Item属性对象),导致Crash;解决方式有两种: <br>
    1).在布局开始时,移除`self.itemAttributesArr`中所有元素,防止数据叠加、并将当前记录的最大Y值数组置nil <br>

        `
        [self.itemAttributesArr removeAllObjects];
        self.tempItemAttributeArrMaxY = nil;
        `
    <br>

    2).在布局开始时,只移除尾标签(最后一个元素)、在遍历取出每个Item共有属性对象前,记录当前`itemAttributesArr`的数组长度,从这个长度开始遍历,直到CollectionView的最后一个元素 <br>
    `
    [self.itemAttributesArr removeLastObject];
    `


