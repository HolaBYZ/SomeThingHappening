//
//  UIImage+LSViewShot.m
//  EasyHomePM
//
//  Created by Leo on 16/8/18.
//  Copyright © 2016年 wzkj. All rights reserved.
//

#import "UIImage+LSViewShot.h"
#import "DHSmartScreenshot.h"
@implementation UIImage (LSViewShot)
+ (UIImage *)getViewShot:(UIView *)view withImageName:(NSString *)imageName{
    UITableView *t = (UITableView *)view;
    CGFloat scale = [UIScreen  mainScreen].scale;
    CGSize headerSize =  CGSizeMake(t.bounds.size.width ,30);
    UIImage *image1 = [t screenshot];
    UIImage *image2 = [self getHeaderImage:imageName withSize:headerSize];
    CGSize size = CGSizeMake(image1.size.width, image1.size.height+image2.size.height);
    UIGraphicsBeginImageContextWithOptions(size,NO,scale);
    [image1 drawInRect:CGRectMake(0, image2.size.height,image1.size.width, image1.size.height)];
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
/**
 *  普通view的截图
 *
 *  @param view view
 *
 *  @return 截图
 */
+ (UIImage *)getCommonShot:(UIView *)view{

    UIGraphicsBeginImageContext(view.bounds.size);
    CGSize size = view.bounds.size;
    CGContextRef context = UIGraphicsGetCurrentContext();
    if ([[UIDevice currentDevice].systemVersion integerValue] > 8.0) {
        [view drawViewHierarchyInRect:CGRectMake(0, 0, size.width, size.height) afterScreenUpdates:YES];
    }else{
        [view.layer renderInContext:context];
    }
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imgData = UIImagePNGRepresentation(img);
    NSString *rootPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString* path = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"img%d.png",55]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //异步写到文件中可打开文件查看
        [imgData writeToFile:path atomically:YES];
    });
    NSLog(@"path:%@",path);
    return img;
}
/**
 *  获得scrollview的截图
 *
 *  @param scrollView scrollView
 *
 *  @return 截图
 */
+ (UIImage *)getHeaderImage:(NSString *)imageName withSize:(CGSize )size{
    CGFloat scale = [UIScreen  mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    UIColor *color = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
  
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment=NSTextAlignmentCenter;//文字居中：
    NSDictionary* attribute = @{
                                NSForegroundColorAttributeName:[UIColor blackColor],//设置文字颜色
                                NSFontAttributeName:[UIFont systemFontOfSize:13],//设置文字的字体
                                NSParagraphStyleAttributeName:paragraphStyle,//设置文字的样式
                                };
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize sizeText = [imageName boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font}context:nil].size;
    CGFloat width = size.width;
    CGFloat height =size.height;
    
    //为了能够垂直居中，需要计算显示起点坐标x,y
    CGRect rect = CGRectMake((width-sizeText.width)/2, (height-sizeText.height)/2, sizeText.width, sizeText.height);
    [imageName drawInRect:rect withAttributes:attribute];
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;

}
+(UIImage *)getTableViewShot:(UIScrollView *)scrollView withImageName:(NSString *)imageName{
    CGFloat scale = [UIScreen  mainScreen].scale;
    CGPoint off = scrollView.contentOffset;
    scrollView.contentOffset = CGPointMake(0, 0);
    NSMutableArray *imgArr = [NSMutableArray array];
    CGFloat contentHight = scrollView.contentSize.height;
    CGFloat imgHight = scrollView.frame.size.height;
    NSInteger imgCount =ceilf(contentHight / imgHight);
    NSString *rootPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    CGSize headerSize =  CGSizeMake(scrollView.bounds.size.width ,30);
    [imgArr addObject: [self getHeaderImage:imageName withSize:headerSize]];
    CGSize contentSize = CGSizeMake(CGRectGetWidth(scrollView.bounds), CGRectGetHeight(scrollView.bounds));
  
    for (int i = 0; i < imgCount;i++){
        UIGraphicsBeginImageContextWithOptions(contentSize,NO,scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if ([[UIDevice currentDevice].systemVersion integerValue] > 8.0) {
            [scrollView drawViewHierarchyInRect:CGRectMake(0, 0, scrollView.bounds.size.width , imgHight) afterScreenUpdates:YES];
        }else{
            [scrollView.layer renderInContext:context];
        }
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        [imgArr addObject:img];
        UIGraphicsEndImageContext();
//        NSData *imgData = UIImagePNGRepresentation(img);
//        NSString* path = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"img%d.png",i]];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//           
//            [imgData writeToFile:path atomically:YES];
//        });
//        NSLog(@"path:%@",path);
        scrollView.contentOffset = CGPointMake(0,scrollView.contentOffset.y +imgHight);
        
    }
    
    NSString *Path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    CGFloat tatolHight = (imgArr.count - 1) * imgHight;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(scrollView.frame.size.width, (tatolHight + headerSize.height)),NO,scale);
    CGFloat orgy = 0;
    for(int i = 0; i < imgArr.count;i++){
        UIImage *image = (UIImage*)imgArr[i];
        [image drawInRect:CGRectMake(0, orgy,image.size.width, image.size.height)];
        orgy += image.size.height;
    }
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    NSString *path = [Path stringByAppendingPathComponent:@"combin.png"];
    NSData *imgData = UIImagePNGRepresentation(img);
    [imgData writeToFile:path atomically:YES];
    scrollView.contentOffset = off;
    return img;
}

//- (UIImage *)getTableViewShot2:(UITableView *)tableView{
//    CGFloat imageHeight;
//    NSMutableArray *images = [NSMutableArray array];
//    NSInteger section = [tableView numberOfSections];
//    UIView *tableViewHeader = tableView.tableHeaderView;
//    if (tableViewHeader) {
//        [images addObject:[self getViewShot2:tableViewHeader]];
//    }
//    for (NSInteger i = 0;i < section; i++) {
//        UIView *header = [tableView headerViewForSection:i];
//        UIView *footer = [tableView footerViewForSection:i];
//        if (header) {
//            [images addObject:[self getViewShot2:header]];
//        }
//        if (footer) {
//            [images addObject:[self getViewShot2:footer]];
//        }
//        NSInteger row = [tableView numberOfRowsInSection:i];
//        for (NSInteger j = 0 ;j < row; j++) {
//            NSIndexPath *index = [NSIndexPath indexPathForRow:j inSection:i];
//            UITableViewCell *cell = [tableView  cellForRowAtIndexPath:index];
//            if (cell) {
//                [images addObject:[self getViewShot2:cell]];
//            }
//
//        }
//    }
//    UIView *tableFooter = [tableView tableFooterView];
//    if (tableFooter) {
//        [images addObject:[self getViewShot2:tableFooter]];
//    }
//    for (UIImage *image in images) {
//        imageHeight += image.size.height;
//    }
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tableView.bounds.size.width,imageHeight), NO, 1);
//    CGFloat orgy = 0;
//    for(int i = 0; i < images.count;i++){
//        UIImage *image = (UIImage*)images[i];
//        [image drawInRect:CGRectMake(0, orgy,image.size.width, image.size.height)];
//        orgy += image.size.height;
//    }
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    NSString *rootPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSData *imgData = UIImagePNGRepresentation(img);
//    NSString* path = [rootPath stringByAppendingPathComponent:@"imgz.png"];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //异步写到文件中可打开文件查看
//        [imgData writeToFile:path atomically:YES];
//    });
//    NSLog(@"path:%@",path);
//
//    return img;
//}
//
//
//-(UIImage *)getViewShot2:(UIView *)view{
//    CGSize size = view.bounds.size;
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    if ([[UIDevice currentDevice].systemVersion integerValue] > 8.0) {
//        [view drawViewHierarchyInRect:CGRectMake(0, 0, size.width, size.height) afterScreenUpdates:NO];
//    }else{
//        [view.layer renderInContext:context];
//    }
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//
//    UIGraphicsEndImageContext();
//
//
//    return img;
//}

@end
