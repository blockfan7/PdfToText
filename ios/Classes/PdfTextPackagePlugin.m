#import "PdfTextPackagePlugin.h"
#if __has_include(<pdf_text_package/pdf_text_package-Swift.h>)
#import <pdf_text_package/pdf_text_package-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pdf_text_package-Swift.h"
#endif

@implementation PdfTextPackagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPdfTextPackagePlugin registerWithRegistrar:registrar];
}
@end
