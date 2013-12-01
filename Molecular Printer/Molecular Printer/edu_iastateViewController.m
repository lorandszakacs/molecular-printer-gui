//
//  edu_iastateViewController.m
//  Molecular Printer
//
//  Created by Lorand Szakacs on 10/11/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import "edu_iastateViewController.h"

#import "MPGModel.h"
#import "PhysicalUnits.h"
#import "Constant.h"
#import "GridCell.h"


@interface edu_iastateViewController ()
@property(nonatomic, weak) IBOutlet UICollectionView *gridView;
-(void) changeValueSlider:(UISlider*)slider :(UILabel*)label :(UIStepper*)stepper;
@end

@implementation edu_iastateViewController
@synthesize tempLabel;
@synthesize tempSlider;
@synthesize deviceTempLabel;
@synthesize humidSlider;
@synthesize humidLabel;
@synthesize columnLabel;
@synthesize columnSlider;
@synthesize columnStepper;
@synthesize rowLabel;
@synthesize rowSlider;
@synthesize rowStepper;
@synthesize widthLabel;
@synthesize widthSlider;
@synthesize widthStepper;
@synthesize heightSlider;
@synthesize heightLabel;
@synthesize heightStepper;
@synthesize spotSlider;
@synthesize spotLabel;
@synthesize spotStepper;
@synthesize model;
@synthesize deviceConnectedLabel;
@synthesize humidImageView;
NSTimer* tempTimer;
NSTimer* humidTimer;
@synthesize ConfigSaveButton;

NSInteger cellHeight;
NSInteger cellWidth;

NSInteger cellsPerRow;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initialization
    model = [[MPGModel alloc] init];
    humidSlider.value = INITIALHUMIDITY;
    humidLabel.text = [[NSString alloc] initWithFormat:@"%1.1f%%", INITIALHUMIDITY];
    tempSlider.value = INITIALTEMP;
    tempLabel.text = [[NSString alloc] initWithFormat:@"%1.1f", INITIALTEMP];
    widthSlider.value = widthSlider.value = INITIALWIDTH;
    widthLabel.text = [[NSString alloc] initWithFormat:@"%1.1fµm", INITIALWIDTH];
    heightSlider.value = heightSlider.value = INITIALHEIGHT;
    heightLabel.text = [[NSString alloc] initWithFormat:@"%1.1fµm", INITIALHEIGHT];
    spotSlider.value = spotStepper.value = INITIALSPOTRADIUS;
    spotLabel.text = [[NSString alloc] initWithFormat:@"%1.1fµm", INITIALSPOTRADIUS];
    
    rowSlider.value = INITIALROWS;
    columnSlider.value = INITIALHEIGHT;
    
    
    //update from device
    tempTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateTemp) userInfo:nil repeats:YES];
    humidTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateHumidity) userInfo:nil repeats:YES];
    
    //grid view
    [self.gridView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GridCell"];
}
-(void)updateTemp{
    deviceTempLabel.text = [[NSString alloc] initWithFormat:@"%1.1f", [model.device.getTemperature getValue]];
}

-(void)updateHumidity{
    humidImageView.image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"humidity%d.png",(int)model.device.getHumidity.getValue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tempSliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [model setTemperature:[[Temperature alloc] initTemperature:slider.value :CELSIUS]];
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1f",
                         [[model getTemperature] getValue]];
    tempLabel.text = newText;
    [model.device setDesiredTemperature:model.getTemperature];
}
- (IBAction)humidSliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [model setHumidity:[[Humidity alloc] initHumidity:slider.value]];
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1f%%",
                         [[model getHumidity] getValue]];
    humidLabel.text = newText;
    [model.device setDesiredHumidity:model.getHumidity];
}

- (IBAction)columnSliderChanged:(id)sender {
    NSInteger newNrOfCols = rowSlider.value;
    NSInteger maxNumOfCols = model.device.getNumberOfPrintableColumns;
    if(newNrOfCols > maxNumOfCols) {
        //TODO: display error;
        return;
    } else {
        [self changeValueSlider:columnSlider :columnLabel :columnStepper];
        [self updateCellDimensions];
    }
}

- (IBAction) columnStepperChanged:(id)sender {
    [self changeValueStepper:columnSlider :columnLabel :columnStepper];
    [self updateCellDimensions];
}


- (IBAction)rowSliderChanged:(id)sender {
    NSInteger newNrOfRows = rowSlider.value;
    NSInteger maxNumOfRows = model.device.getNumberOfPrintableRows;
    if(newNrOfRows > maxNumOfRows) {
        //TODO: display error;
        return;
    } else {
        [self changeValueSlider:rowSlider :rowLabel :rowStepper];
        [self updateCellDimensions];
    }
    
}

- (IBAction) rowStepperChanged:(id)sender {
    [self changeValueStepper:rowSlider :rowLabel :rowStepper];
        [self updateCellDimensions];
}

- (IBAction)widthSliderChanged:(id)sender {
    [self changeValueSlider:widthSlider :widthLabel :widthStepper];
    [model setPitch:[[Pitch alloc] initPitch:widthSlider.value :[model.getPitch getHeight] :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm", [model.getPitch getWidth]];
    widthLabel.text = newText;
    [self updateSpotSize:widthSlider.value];
}

- (IBAction) widthStepperChanged:(id)sender {
    [self changeValueStepper:widthSlider :widthLabel :widthStepper];
    [model setPitch:[[Pitch alloc] initPitch:widthStepper.value :[model.getPitch getHeight] :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getPitch getWidth]];
    widthLabel.text = newText;
    [self updateSpotSize:widthSlider.value];
}

- (IBAction)heightSyncButtonPressed:(id)sender {
    [model setPitch:[[Pitch alloc] initPitch:[model.getPitch getHeight] :[model.getPitch getHeight] :[model.getPitch getUnit]]];
    float width = [model.getPitch getWidth];
    widthSlider.value = width;
    widthStepper.value = width;
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1fµm",
                         width];
    widthLabel.text = newText;
}

- (IBAction)heightSliderChanged:(id)sender {
    [self changeValueSlider:heightSlider :heightLabel :heightStepper];
    [model setPitch:[[Pitch alloc] initPitch:[model.getPitch getWidth] :heightSlider.value :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getPitch getHeight]];
    heightLabel.text = newText;
    [self updateSpotSize:heightSlider.value];
}

- (IBAction) heightStepperChanged:(id)sender {
    [self changeValueStepper:heightSlider :heightLabel :heightStepper];
    [model setPitch:[[Pitch alloc] initPitch:[model.getPitch getWidth] :heightStepper.value :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getPitch getHeight]];
    heightLabel.text = newText;
    [self updateSpotSize:heightSlider.value];
}

//sync height with width
- (IBAction)widthSyncButtonPressed:(id)sender {
    [model setPitch:[[Pitch alloc] initPitch:[model.getPitch getWidth] :[model.getPitch getWidth] :[model.getPitch getUnit]]];
    float height = [model.getPitch getHeight];
    heightSlider.value = height;
    heightStepper.value = height;
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1fµm",
                         height];
    heightLabel.text = newText;
}

- (IBAction)spotSliderChanged:(id)sender {
    [self changeValueSlider:spotSlider :spotLabel :spotStepper];
    [model setSpot:[[Spot alloc] initSpot:spotSlider.value :[model.spot getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getSpot getRadius]];
    spotLabel.text = newText;
    
}

- (IBAction) spotStepperChanged:(id)sender {
    [self changeValueStepper:spotSlider :spotLabel :spotStepper];
    [model setSpot:[[Spot alloc] initSpot:spotStepper.value :[model.spot getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getSpot getRadius]];
    spotLabel.text = newText;
}

-(void) changeValueSlider:(UISlider*)slider :(UILabel*)label :(UIStepper*)stepper{
    NSString *newText = [[NSString alloc] initWithFormat:@"%d",
                         (int)slider.value];
    label.text = newText;
    stepper.value = slider.value;
}

-(void) changeValueStepper:(UISlider*)slider :(UILabel*)label :(UIStepper*)stepper{
    NSString *newText = [[NSString alloc] initWithFormat:@"%d",
                         (int)stepper.value];
    label.text = newText;
    slider.value = stepper.value;
}

/*
 *  updating cell height/width when the rows/columns sliders change.
 */
-(void) updateCellDimensions {
    
//    if(MAXIMAGEWIDTH/value<[model.getPitch getWidth]){
//        [model setPitch:[[Pitch alloc] initPitch:[] :<#(double)#> :<#(LengthUnit)#>
//        widthSlider.value = IMAGEWIDTH/value;
//        widthStepper.value = MAXIMAGEWIDTH/value;
//        NSString *newText = [NSString stringWithFormat: @"%1.1fµm",widthSlider.value];
//        widthLabel.text =newText;
//    }
//    widthSlider.maximumValue = IMAGEWIDTH/value;
//    widthStepper.maximumValue = IMAGEWIDTH/value;
}

-(void) updateSpotSize:(float)value{
    //TODO:adjust spot size accordingly to changes to pitches
}


//Device selection
- (IBAction)deviceButton:(id)sender {
    if(_deviceSelection == nil){
        _deviceSelection = [[DeviceSelectionViewController alloc] initWithStyle:UITableViewStylePlain];
        _deviceSelection.delegate = self;
    }
    
    if(_deviceSelectionPopover ==nil){
        _deviceSelectionPopover = [[UIPopoverController alloc] initWithContentViewController:_deviceSelection];
        [_deviceSelectionPopover presentPopoverFromRect:_deviceSelectButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }else{
        [_deviceSelectionPopover dismissPopoverAnimated:YES];
        _deviceSelectionPopover = nil;
    }
    
}
-(void)selectedDevice:(MicroControllerInterface *)device{
    deviceConnectedLabel.text = [device getID];
    [model setDevice:device];
    
    if(_deviceSelectionPopover!=nil){
        [_deviceSelectionPopover dismissPopoverAnimated:YES];
        _deviceSelectionPopover = nil;
    }
}

//Config S/L
- (IBAction)configSaveButtonPushed:(id)sender {
    if(_saveConfigController == nil){
        _saveConfigController = [[SaveConfigViewController alloc] init];
        _saveConfigController.contentSizeForViewInPopover = CGSizeMake(187, 196);//hard coded:calculated from position of views.
//        _saveConfigController.delegate = self;
    }
    
    if(_saveConfigPopover ==nil){
        _saveConfigPopover = [[UIPopoverController alloc] initWithContentViewController:_saveConfigController];
        [_saveConfigPopover presentPopoverFromRect:ConfigSaveButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }else{
        [_saveConfigPopover dismissPopoverAnimated:YES];
        _saveConfigPopover = nil;
    }
}

//====================
//    Grid View
//====================
#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    GridMatrix *mat = model.gridMatrix;
    if(mat != nil){
        NSInteger total = mat.getHeight * mat.getWidth;
        return total;
    } else {
    
    }
    return 1;
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    GridMatrix *mat = model.gridMatrix;
    if(mat != nil){
        return mat.getHeight;
    } else {
        return rowSlider.value;
    }
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GridCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"GridCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
// 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger column = indexPath.section;
    [self.gridView deselectItemAtIndexPath:indexPath animated:NO];
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *searchTerm = self.searches[indexPath.section]; FlickrPhoto *photo =
//    self.searchResults[searchTerm][indexPath.row];
    // 2
    CGSize retval = CGSizeMake(100, 100);
//    retval.height += 35; retval.width += 35; return retval;
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}
@end
