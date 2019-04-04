//
//  ColletionviewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/4.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "ColletionviewController.h"
#import "WaterFlowLayout.h"
@interface UICollectionCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *label;

@end

@implementation UICollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    _label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    [self addSubview:_label];
    _label.numberOfLines = 0;
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _label.textColor = [UIColor whiteColor];
}


@end

@interface ColletionviewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
WaterFlowLayoutDelegate
>
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, strong) NSMutableArray *allcolor;
@end

@implementation ColletionviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView
{
    [self.view addSubview:self.collectionview];
}

- (NSMutableArray *)heightArray
{
    if (!_heightArray) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}

#pragma mark -- collectionveiw
- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        WaterFlowLayout *layout = [[WaterFlowLayout alloc] init];
        layout.delegate = self;
        _collectionview = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        WeakSelf;
        [_collectionview registerClass:[UICollectionCell class] forCellWithReuseIdentifier:@"idcell"];

        _collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

            weakSelf.heightArray = nil;
             weakSelf.totalCount = 10;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.collectionview.mj_header endRefreshing];
                [weakSelf.collectionview.mj_footer endRefreshing];
                [weakSelf.collectionview reloadData];
            });
           
        }];
        _collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.totalCount = weakSelf.totalCount + 10;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.collectionview.mj_header endRefreshing];
                [weakSelf.collectionview.mj_footer endRefreshing];
                [weakSelf.collectionview reloadData];
            });
            
        }];
        
        [_collectionview.mj_header beginRefreshing];
    }
    return _collectionview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    collectionView.mj_footer.hidden = _totalCount == 0;
    return _totalCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"idcell" forIndexPath:indexPath];

    cell.contentView.backgroundColor = RandColor;
    cell.label.text = [NSString stringWithFormat:@" %ld x %ld", indexPath.section, indexPath.row];
   
    return cell;
}

- (CGFloat)waterFlowLayout:(WaterFlowLayout *)waterFlowLayout heigthForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    
    if (index < self.heightArray.count) {
        return [self.heightArray[index] floatValue];
    }
    
    CGFloat height = random()%200;
    if (height < 100) {
        height = 100;
    }
    
    [self.heightArray addObject:[NSNumber numberWithFloat:height]];
    
    return height;
}

- (CGFloat)columnCountInWaterflowLayout:(WaterFlowLayout *)waterflowLayout {
    return 3;
}
- (CGFloat)columnMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout {
    return 10;
}
- (CGFloat)rowMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout {
    return 10;
}
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterFlowLayout *)waterflowLayout {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
