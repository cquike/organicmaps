#import "Macros.h"
#import "MWMSearchCategoriesManager.h"
#import "MWMSearchCategoryCell.h"
#import "Statistics.h"

#include "base/macros.hpp"

static NSString * const kCellIdentifier = @"MWMSearchCategoryCell";

static char const * categoriesNames[] = {
    "food", "hotel", "tourism",       "wifi",     "transport", "fuel",   "parking", "shop",
    "atm",  "bank",  "entertainment", "hospital", "pharmacy",  "police", "toilet",  "post"};
static size_t const kCategoriesCount = ARRAY_SIZE(categoriesNames);

@implementation MWMSearchCategoriesManager

- (void)attachCell:(MWMSearchTabbedCollectionViewCell *)cell
{
  cell.noResultsView.hidden = YES;
  UITableView * tableView = cell.tableView;
  tableView.hidden = NO;
  tableView.delegate = self;
  tableView.dataSource = self;
  [tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil]
  forCellReuseIdentifier:kCellIdentifier];
  [tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return kCategoriesCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 44.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(MWMSearchCategoryCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
  [cell setCategory:@(categoriesNames[indexPath.row]) isLightTheme:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString * string = @(categoriesNames[indexPath.row]);
  [Statistics.instance logEvent:@"Category Selection" withParameters:@{ @"Category" : string }];
  [self.delegate searchText:[L(string) stringByAppendingString:@" "] forInputLocale:nil];
}

@end
