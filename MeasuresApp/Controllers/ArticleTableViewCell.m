//
//  ArticleTableViewCell.m
//  MeasuresApp
//
//  Created by Admin on 28.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "ArticleTableViewCell.h"

static float const fontSizeInfo = 10.0f;
static float const spaceBetweenView = 15.0f;
static int const tagView = 10;
static float const constHeigthOfTopPartCell = 120.0f;

@implementation ArticleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFieldsDate:(NSDate*)_dateSet
                title:(NSString*)_titleSet
             subtitle:(NSString*)_subtitleSet
            imgAvatar:(UIImage*)_imgAvatarSet
                 info:(NSString*)_infoSet
            imgBanner:(UIImage*)_imgBannerSet
{
    // Top part
    self.lblDate.text = [HelperClass convertDate:_dateSet toStringFormat:@"dd MMMM yyyy"];
    
    if(_imgAvatarSet)
        self.imgAvatar.image = _imgAvatarSet;
    
    self.lblTitle.attributedText = [self setTitle:_titleSet
                                          andInfo:_subtitleSet];
    self.heigthLblTitleStart = CGRectGetHeight(self.lblTitle.frame);
    [self.lblTitle sizeToFit];
    
    //[self divideInfoBetweenTopAnBottomPart:_infoSet andBannerImage:_imgBannerSet];
    
    //self.cellHeight = [self calculationOfPosYTopLblOnfo];
    //[self setHeightOfCell];
    //CGRect testR = self.lblTopInfo.frame;
    //testR.origin.y = [self calculationOfPosYTopLblOnfo];
   //self.lblTopInfo.frame = testR;
    //[self setLblInfoAttribute:self.lblTopInfo];
    self.lblTopInfo.text = _infoSet;
    [self.lblTopInfo sizeToFit];
    //[self setHeightOfCell];
}

- (float)calculationOfPosYTopLblOnfo
{
    float heigthCellTopPart;
    float heigthLblTitle = CGRectGetHeight(self.lblTitle.frame);
    if(self.heigthLblTitleStart >= heigthLblTitle)
        heigthCellTopPart = constHeigthOfTopPartCell;
    else {
        heigthCellTopPart = constHeigthOfTopPartCell + (heigthLblTitle - self.heigthLblTitleStart);
    }
    return heigthCellTopPart;
}

- (void)divideInfoBetweenTopAnBottomPart:(NSString*)_info andBannerImage:(UIImage*)_imgBannerSet
{
    if(!_info){
        [self setBannerImage:_imgBannerSet];
        return;
    }
    
    NSString * strTop;
    NSString * strBottom;
    NSString * strInfo = _info;
    strInfo = [strInfo substringToIndex:(int)(_info.length/2)];
    
    NSRange rangeTopPart = [strInfo rangeOfString:@"." options:(NSBackwardsSearch)];
    if(rangeTopPart.location == NSNotFound){
        strTop = _info;
        strBottom = nil;
    } else {
        strTop = [_info substringToIndex:rangeTopPart.location];
        strBottom = [_info substringFromIndex:(rangeTopPart.location + 1)];
    }
    
    // Top Info Label
    self.lblTopInfo.frame = /*[[UILabel alloc] initWithFrame:*/CGRectMake(CGRectGetMinX(self.vwLeftContainer.frame), [self calculationOfPosYTopLblOnfo], (CGRectGetWidth(self.vwLeftContainer.frame)*2), 20.0f);//];
    [self setLblInfoAttribute:self.lblTopInfo];
    self.lblTopInfo.text = strTop;
    self.lblTopInfo.backgroundColor = [UIColor redColor];
    //[self addSubview:self.lblTopInfo];
    [self.lblTopInfo sizeToFit];
    
    // Banner image
    //[self setBannerImage:_imgBannerSet];
    
    // Bottom Info Label
    if(!strBottom)
        return;
    
    float lblInfoBottomPosY = 0;
    if(!self.imgBanner)
        lblInfoBottomPosY = CGRectGetMaxY(self.lblTopInfo.frame);
    else
        lblInfoBottomPosY = CGRectGetMaxY(self.imgBanner.frame) + spaceBetweenView;
    
    self.lblBottomInfo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.vwLeftContainer.frame), [self calculationOfPosYTopLblOnfo], (CGRectGetWidth(self.vwLeftContainer.frame)*2), 20.0f)];
    [self setLblInfoAttribute:self.lblBottomInfo];
    self.lblBottomInfo.text = strBottom;
    [self.lblBottomInfo sizeToFit];
    //[self addSubview:self.lblBottomInfo];
}

- (void)setBannerImage:(UIImage*)_imgBannerSet
{
    // Banner image
    if(!_imgBannerSet)
        return;
    
    if(_lblTopInfo)
        self.imgBanner = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.vwLeftContainer.frame), (CGRectGetMaxY(self.lblTopInfo.frame) + spaceBetweenView), CGRectGetWidth(self.lblTopInfo.frame), 120.0f)];
    else self.imgBanner = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.vwLeftContainer.frame), [self calculationOfPosYTopLblOnfo], (CGRectGetWidth(self.vwLeftContainer.frame)*2), 120.0f)];
    
    self.imgBanner.contentMode = UIViewContentModeScaleAspectFit;
    self.imgBanner.image = _imgBannerSet;
    self.imgBanner.tag = tagView;
    
    [self addSubview:self.imgBanner];
}

- (void)setLblInfoAttribute:(UILabel*)_lblInfo{
    [_lblInfo setFont:[UIFont fontWithName:constFontArial size:fontSizeInfo]];
    _lblInfo.textAlignment = NSTextAlignmentLeft;
    [_lblInfo setTextColor:[UIColor blackColor]];
    _lblInfo.tag = tagView;
}

- (void)setHeightOfCell{
   /* NSMutableArray * arr = [NSMutableArray new];
    
    for (UIView * vw in self.subviews) {
        if(vw.tag == tagView)
           [arr addObject:vw];
    }
    
    if(arr.count == 0)
        return;
    
    self.cellHeight = CGRectGetMaxY(((UIView*)[arr lastObject]).frame) + spaceBetweenView;
    */
    self.cellHeight = CGRectGetMaxY(self.lblTopInfo.frame) + spaceBetweenView;
}

@end
