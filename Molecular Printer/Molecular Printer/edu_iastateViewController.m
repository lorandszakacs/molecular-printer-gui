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
@synthesize ConfigLoadButton;

NSInteger cellDimension;
NSInteger cellSpacing;

NSInteger cellsPerRow;
NSInteger cellsPerColumn;



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
    rowLabel.text = [[NSString alloc] initWithFormat:@"%d", INITIALROWS];
    columnSlider.value = INITIALCOLUMNS;
    columnLabel.text = [[NSString alloc] initWithFormat:@"%d", INITIALCOLUMNS];
    
    //display constants
    cellsPerRow = INITIALROWS;
    cellsPerColumn = INITIALCOLUMNS;
    cellSpacing = GRID_DISPLAY_SPACE;
    cellDimension = [self computeCellDimensions];
    
    //update from device
    tempTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateTemp) userInfo:nil repeats:YES];
    humidTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateHumidity) userInfo:nil repeats:YES];
    
    //grid view
    [self.gridView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GridCell"];
}
-(NSInteger)computeCellDimensions{
    NSInteger maxVertical = GRID_DISPLAY_HEIGHT/(cellsPerRow + cellSpacing);
    NSInteger maxHorizontal = GRID_DISPLAY_WIDTH/(cellsPerColumn + cellSpacing);
    if(maxVertical > maxHorizontal)
        return maxVertical;
    else
        return maxHorizontal;
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
    [self changeValueSlider:columnSlider :columnLabel :columnStepper];
    [self updateCellDimensions];

//    NSInteger newNrOfCols = rowSlider.value;
//    NSInteger maxNumOfCols = model.device.getNumberOfPrintableColumns;
//    if(newNrOfCols > maxNumOfCols) {
//        //TODO: display error;
//        return;
//    } else {
//
//    }
}

- (IBAction) columnStepperChanged:(id)sender {
    //TODO: update like the slider counterpart
    [self changeValueStepper:columnSlider :columnLabel :columnStepper];
    [self updateCellDimensions];
}


- (IBAction)rowSliderChanged:(id)sender {
    [self changeValueSlider:rowSlider :rowLabel :rowStepper];
    [self updateCellDimensions];

//    NSInteger newNrOfRows = rowSlider.value;
//    NSInteger maxNumOfRows = model.device.getNumberOfPrintableRows;
//    if(newNrOfRows > maxNumOfRows) {
//        //TODO: display error;
//        return;
//    } else {
//
//    }
}

- (IBAction) rowStepperChanged:(id)sender {
    //TODO: update like the slider counterpart
    [self changeValueStepper:rowSlider :rowLabel :rowStepper];
        [self updateCellDimensions];
}

- (IBAction)widthSliderChanged:(id)sender {
    [self changeValueSlider:widthSlider :widthLabel :widthStepper];
    [model setPitch:[[Pitch alloc] initPitch:widthSlider.value :[model.getPitch getHeight] :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm", [model.getPitch getWidth]];
    widthLabel.text = newText;
}

- (IBAction) widthStepperChanged:(id)sender {
    [self changeValueStepper:widthSlider :widthLabel :widthStepper];
    [model setPitch:[[Pitch alloc] initPitch:widthStepper.value :[model.getPitch getHeight] :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getPitch getWidth]];
    widthLabel.text = newText;
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
}

- (IBAction) heightStepperChanged:(id)sender {
    [self changeValueStepper:heightSlider :heightLabel :heightStepper];
    [model setPitch:[[Pitch alloc] initPitch:[model.getPitch getWidth] :heightStepper.value :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getPitch getHeight]];
    heightLabel.text = newText;
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


//Printing actions
- (IBAction)PrintButtonPushed:(id)sender {
    GridMatrix* grid = model.getGridMatrix;
    for(int i=0;i<model.getGridMatrix.getHeight;i++){
        for(int j=0;j<model.getGridMatrix.getWidth;j++){
                if([grid isMarked:i :j])
                    [model.device print:i :j];
        }
    }///////DATA race issue???
//    PrintWaitViewController* pView = [[PrintWaitViewController alloc] init];
//    [self presentViewController:pView animated:YES completion:NO];
//    [pView print];
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

//Image save/load
-(void)ImageLoaderButtonPushed2{
    GridMatrix* grid = [[GridMatrix alloc] initGridMatrix:10 :10];
    for(int i=0;i<10;i++){
        for(int j=0;j<10;j++){
            if(i==j)
                [grid mark:i :j];
            if(i+j==9)
                [grid mark:i :j];
        }
    }
    [grid mark:1 :0];
    [grid mark:0 :1];
    [grid mark:4 :0];
    [grid mark:5 :0];
    [grid mark:8 :0];
    [grid mark:9 :1];
    
    
    [self updateCellDimensions];//use this when implemented
    
    [model setGridMatrix:grid];
    
    rowSlider.value = rowStepper.value = model.getGridMatrix.getHeight;
    columnSlider.value = columnStepper.value = model.getGridMatrix.getWidth;
    NSString *newText = [[NSString alloc] initWithFormat:@"%d",
                         model.getGridMatrix.getWidth];
    columnLabel.text = newText;
    newText = [[NSString alloc] initWithFormat:@"%d",
               model.getGridMatrix.getHeight];
    rowLabel.text = newText;
    
    
    
    
    if(_imageLoaderPopover!=nil){
        [_imageLoaderPopover dismissPopoverAnimated:YES];
        _imageLoaderPopover = nil;
    }
    
}
- (IBAction)LoadImageButtonPushed:(id)sender {
    if(!_saved){
        if(_imageLoaderViewController == nil){
            _imageLoaderViewController = [[ImageLoaderViewController alloc] init];
            _imageLoaderViewController.contentSizeForViewInPopover = CGSizeMake(330, 196);//hard coded:calculated from position of views.
            _imageLoaderViewController.delegate = self;
        }
        
        if(_imageLoaderPopover ==nil){
            _imageLoaderPopover = [[UIPopoverController alloc] initWithContentViewController:_imageLoaderViewController];
            [_imageLoaderPopover presentPopoverFromRect:_loadImageButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        }else{
            [_imageLoaderPopover dismissPopoverAnimated:YES];
            _imageLoaderPopover = nil;
        }
    }else{
        if(_imageLoaderViewController2 == nil){
            _imageLoaderViewController2 = [[ImageLoaderViewController2 alloc] init];
//            _imageLoaderViewController2.contentSizeForViewInPopover = CGSizeMake(330, 196);//hard coded:calculated from position of views.
            _imageLoaderViewController2.delegate = self;
        }
        
        if(_imageLoaderPopover ==nil){
            _imageLoaderPopover = [[UIPopoverController alloc] initWithContentViewController:_imageLoaderViewController2];
            [_imageLoaderPopover presentPopoverFromRect:_loadImageButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        }else{
            [_imageLoaderPopover dismissPopoverAnimated:YES];
            _imageLoaderPopover = nil;
        }
    }
}
//imageLoadDelegate
- (void)ImageLoaderButtonPushed{
    GridMatrix* grid = [[GridMatrix alloc] initGridMatrix:10 :10];
    for(int i=0;i<10;i++){
        for(int j=0;j<10;j++){
            if(i==j)
                [grid mark:i :j];
            if(i+j==9)
                [grid mark:i :j];
        }
    }
    
    
    [self updateCellDimensions];//use this when implemented
    
    [model setGridMatrix:grid];
    
    rowSlider.value = rowStepper.value = model.getGridMatrix.getHeight;
    columnSlider.value = columnStepper.value = model.getGridMatrix.getWidth;
    NSString *newText = [[NSString alloc] initWithFormat:@"%d",
                         model.getGridMatrix.getWidth];
    columnLabel.text = newText;
    newText = [[NSString alloc] initWithFormat:@"%d",
                         model.getGridMatrix.getHeight];
    rowLabel.text = newText;
    
    
    

    if(_imageLoaderPopover!=nil){
        [_imageLoaderPopover dismissPopoverAnimated:YES];
        _imageLoaderPopover = nil;
    }
}

-(void)imageSaveSelected{
    if(_imageSaverPopover != nil){
        [_imageSaverPopover dismissPopoverAnimated:YES];
        _imageSaverPopover = nil;
        _imageSaverViewController =nil;
    }
    _saved = YES;
}

- (IBAction)SaveImageButtonPushed:(id)sender {
    if(_imageSaverViewController == nil){
        _imageSaverViewController = [[ImageSaverViewController alloc] init];
        _imageSaverViewController.contentSizeForViewInPopover = CGSizeMake(187, 196);//hard coded:calculated from position of views.
        _imageSaverViewController.delegate = self;
    }
    
    if(_imageSaverPopover ==nil){
        _imageSaverPopover = [[UIPopoverController alloc] initWithContentViewController: _imageSaverViewController];
        [_imageSaverPopover presentPopoverFromRect: _saveImageButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }else{
        [_imageSaverPopover dismissPopoverAnimated:YES];
        _imageSaverPopover = nil;
    }
}
//Config S/L
- (IBAction)configSaveButtonPushed:(id)sender {
    if(_saveConfigController == nil){
        _saveConfigController = [[SaveConfigViewController alloc] initWithData:[model getTemperature] :[model getHumidity] :[model getPitch] :[model getSpot]];
        _saveConfigController.contentSizeForViewInPopover = CGSizeMake(187, 196);//hard coded:calculated from position of views.
        _saveConfigController.delegate = self;
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
        [NSException raise:@"Model not initialized properly" format:@"Model grid matrix not initialized properly when trying to display grid"];
    }
    return 1;
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
//    GridMatrix *mat = model.gridMatrix;
//    if(mat != nil){
//        return mat.getHeight;
//    } else {
//        return rowSlider.value;
//    }
    return 1;
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
    CGSize retval = CGSizeMake(cellDimension, cellDimension);
//    retval.height += 35; retval.width += 35; return retval;
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing);
}

- (IBAction)configLoadButtonPushed:(id)sender {
    if(_loadConfigController == nil){
        _loadConfigController = [[LoadConfigViewController alloc] init];
//        _loadConfigController.contentSizeForViewInPopover = CGSizeMake(187, 196);//hard coded:calculated from position of views.
        _loadConfigController.delegate = self;
    }
    
    if(_loadConfigPopover ==nil){
        _loadConfigPopover = [[UIPopoverController alloc] initWithContentViewController:_loadConfigController];
        [_loadConfigPopover presentPopoverFromRect:ConfigLoadButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }else{
        [_loadConfigPopover dismissPopoverAnimated:YES];
        _loadConfigPopover = nil;
        _loadConfigController = nil;
    }

}

//delegate methods
-(void)selectedConfigurations:(Configuration *)config{
    [self loadTemp:config];
    [self loadHumid:config];
    [self loadPitch:config];
    [self loadSpot:config];
    
    if(_loadConfigPopover!=nil){
        [_loadConfigPopover dismissPopoverAnimated:YES];
        _loadConfigPopover = nil;
        _loadConfigController = nil;
    }
}
-(void)configSaveSelected{
    if(_saveConfigPopover != nil){
        [_saveConfigPopover dismissPopoverAnimated:YES];
        _saveConfigPopover = nil;
        _saveConfigController =nil;
    }
}

-(void)loadTemp:(Configuration*) config{
    [model setTemperature:[[Temperature alloc]initTemperature:config.temp :CELSIUS]];
    tempSlider.value = config.temp;
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1f",
                         [[model getTemperature] getValue]];
    tempLabel.text = newText;
}
-(void)loadHumid:(Configuration*) config{
    [model setHumidity:[[Humidity alloc]initHumidity:config.humid]];
    humidSlider.value = config.humid;
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1f%%",
                         [[model getHumidity] getValue]];
    humidLabel.text = newText;
}
-(void)loadPitch:(Configuration*) config{
    [model setPitch:[[Pitch alloc]initPitch :config.width :config.height :MICROMETER]];
    widthSlider.value = widthStepper.value = config.width;
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm", [model.getPitch getWidth]];
    widthLabel.text = newText;
    heightSlider.value = heightStepper.value = config.height;
    newText = [NSString stringWithFormat: @"%1.1fµm", [model.getPitch getHeight]];
    heightLabel.text = newText;
}
-(void)loadSpot:(Configuration*) config{
    [model setSpot:[[Spot alloc]initSpot:config.spot :MICROMETER]];
    spotSlider.value = spotStepper.value = config.spot;
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm", [model.getSpot getRadius]];
    spotLabel.text = newText;
}



@end
