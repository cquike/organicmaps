#import "MWMSearchTextField.h"

@implementation MWMSearchTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (!self)
    return nil;
  self.isSearching = NO;
  self.leftViewMode = UITextFieldViewModeAlways;
  return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
  CGRect rect = [super leftViewRectForBounds:bounds];
  rect.origin.x += 8.0;
  return rect;
}

#pragma mark - Properties

- (void)setIsSearching:(BOOL)isSearching
{
  _isSearching = isSearching;
  if (isSearching)
  {
    UIActivityIndicatorView * view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [view startAnimating];
    view.bounds = self.leftView.bounds;
    self.leftView = view;
  }
  else
  {
    self.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_searchbar_search_light"]];
  }
}

@end
