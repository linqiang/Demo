#######################################
# ZipArchive for Objective-C          #
# created by: aish (acsolu@gmail.com) #
# blog: www.flyblog.info	      #	
# version 1.1                         #
#######################################

Objective-C class used to zip / unzip compressed zip file. 

Usage:
Add all the files to you project, and and framework libz.1.2.3.dylib.

include ZipArchive.h using #import "ZipArchive/ZipArchive.h" 

* create zip file
ZipArchive* zipFile = [[ZipArchive alloc] init];
[zipFile CreateZipFile2:@"zipfilename"]; // A
OR
[[zipFile CreateZipFile2:@"zipfilename" Password:@"your password"];// if password needed, 
								   //empty password will get same result as A

[zipFile addFileToZip:@"fullpath of the file" newname:@"new name of the file without path"];
....add any number of files here
[zipFile CloseZipFile2];
[zipFile release]; // remember to release the object

* unzip compressed file
ZipArchive* zipFile = [[ZipArchive alloc] init];
[zipFile UnzipOpenFile:@"zip file name"]; // B (the zip got no password)
OR
[zipFile UnzipOpenFile:@"zip file name" Password:@"password" ];

[zipFile UnzipFileTo:@"output path" overwrite:YES];
[zipFile UnzipCloseFile];
[zipFile release];



