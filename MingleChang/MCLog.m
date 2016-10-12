//
//  MCLog.m
//  MingleChang
//
//  Created by 常峻玮 on 16/5/12.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import "MCLog.h"
#import <mach/mach_time.h>

static NSString* directoryName=@"MCLOG_DIRECTORY";

@interface MCLogManager : NSObject

@property(nonatomic,copy)NSString *directoryPath;
@property(nonatomic,copy)NSString *filePath;
@property(nonatomic,strong)NSFileHandle *fileHandle;

@property(nonatomic,strong)NSDateFormatter *formatter;

+(MCLogManager *)instance;

@end

@implementation MCLogManager

+(MCLogManager *)instance{
    static MCLogManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[MCLogManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        [self checkDirectory];
    }
    return self;
}

-(void)checkDirectory{
    BOOL isDirectory;
    BOOL isExists=[[NSFileManager defaultManager]fileExistsAtPath:self.directoryPath isDirectory:&isDirectory];
    if (!isExists) {
        [[NSFileManager defaultManager]createDirectoryAtPath:self.directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        return;
    }
    if (!isDirectory) {
        [[NSFileManager defaultManager]removeItemAtPath:self.directoryPath error:nil];
        [[NSFileManager defaultManager]createDirectoryAtPath:self.directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        return;
    }
}

-(void)createLogDirectotyWith:(NSString *)name{
    [self checkDirectory];
    NSString *directoryName=[self directotyNameWithName:name];
    NSString *directoryPath=[self.directoryPath stringByAppendingPathComponent:directoryName];
    BOOL isDiretory=NO;
    if ([[NSFileManager defaultManager]fileExistsAtPath:directoryPath isDirectory:&isDiretory]) {
        if (isDiretory) {
            self.filePath=directoryPath;
        }else{
            [[NSFileManager defaultManager]removeItemAtPath:directoryPath error:nil];
            [[NSFileManager defaultManager]createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
            self.filePath=directoryPath;
        }
    }else{
        [[NSFileManager defaultManager]createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        self.filePath=directoryPath;
    }
}

-(void)createLogFileWith:(NSString *)name{
    [self checkDirectory];
    if (self.fileHandle) {
        [self.fileHandle closeFile];
        self.fileHandle=nil;
        self.filePath=nil;
    }
    NSString *fileName=[self fileNameWithName:name];
    NSString *filePath=[self.directoryPath stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        self.filePath=filePath;
        self.fileHandle=[NSFileHandle fileHandleForUpdatingAtPath:filePath];
    }else if ([[NSFileManager defaultManager]createFileAtPath:filePath contents:nil attributes:nil]){
        self.filePath=filePath;
        self.fileHandle=[NSFileHandle fileHandleForUpdatingAtPath:filePath];
    }else{
        self.filePath=nil;
        self.fileHandle=nil;
    }
    NSLog(@"%@",filePath);
}
-(NSString *)directotyNameWithName:(NSString *)name{
    NSDate *lNowDate=[NSDate date];
    NSString *dateStr=[self.formatter stringFromDate:lNowDate];
    NSString *fileName=[NSString stringWithFormat:@"%@_%@.txt",name,dateStr];
    return fileName;
}
-(NSString *)fileNameWithName:(NSString *)name{
    NSDate *lNowDate=[NSDate date];
    NSString *dateStr=[self.formatter stringFromDate:lNowDate];
    NSString *fileName=[NSString stringWithFormat:@"%@_%@.txt",name,dateStr];
    return fileName;
}
-(void)writeToFileWith:(NSString *)log{
    NSDate *lNowDate=[NSDate date];
    NSString *dateStr=[self.formatter stringFromDate:lNowDate];
    NSString *filePath=[self.filePath stringByAppendingPathComponent:dateStr];
    [log writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    [self.fileHandle writeData:[log dataUsingEncoding:NSUTF8StringEncoding]];
}
-(NSArray *)allLogFiles{
    return [[NSFileManager defaultManager]contentsOfDirectoryAtPath:self.directoryPath error:nil];
}
-(void)cleanAllLogs{
    [self.fileHandle closeFile];
    self.filePath=nil;
    self.fileHandle=nil;
    [[NSFileManager defaultManager]removeItemAtPath:self.directoryPath error:nil];
}
#pragma mark - Setter And Getter
-(NSString *)directoryPath{
    if (_directoryPath) {
        return _directoryPath;
    }
    NSString *lTmpPath=NSTemporaryDirectory();
    _directoryPath=[lTmpPath stringByAppendingPathComponent:directoryName];
    return _directoryPath;
}
-(NSDateFormatter *)formatter{
    if (_formatter) {
        return _formatter;
    }
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:Z"];
    return _formatter;
}
@end


@interface MCLog ()


@end

@implementation MCLog

+(void)configureLog:(NSString *)log{
//    [[MCLogManager instance]createLogFileWith:log];
    [[MCLogManager instance]createLogDirectotyWith:log];
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}
+(void)log:(NSString *)log{
    NSLog(@"%@",log);
    [[MCLogManager instance]writeToFileWith:log];
}
+(NSArray *)allLogFiles{
    return [[MCLogManager instance]allLogFiles];
}
+(NSString *)filePathByName:(NSString *)name{
    return [[MCLogManager instance].directoryPath stringByAppendingPathComponent:name];
}
+(void)cleanAllLogs{
    [[MCLogManager instance]cleanAllLogs];
}
void uncaughtExceptionHandler(NSException *exception){
    NSString *logString=[NSString stringWithFormat:@"%@\n%@\n%@\n",exception.name,exception.reason,exception.callStackSymbols];
    [[MCLogManager instance]writeToFileWith:logString];
}
@end
