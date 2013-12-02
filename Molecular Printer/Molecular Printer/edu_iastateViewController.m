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

@property(atomic) NSInteger cellDimension;
@property(atomic) NSInteger cellSpacing;
@property(atomic) NSInteger cellsPerRow;
@property(atomic) NSInteger cellsPerColumn;

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
    //TODO: Should get from model;
    rowSlider.maximumValue = 10;
    rowLabel.text = [[NSString alloc] initWithFormat:@"%d", INITIALROWS];
    columnSlider.value = INITIALCOLUMNS;
    columnSlider.maximumValue = 10;
    columnLabel.text = [[NSString alloc] initWithFormat:@"%d", INITIALCOLUMNS];
    
    //display constants
    self.cellsPerRow = INITIALROWS;
    self.cellsPerColumn = INITIALCOLUMNS;
    self.cellSpacing = GRID_DISPLAY_SPACE;
    self.cellDimension = [self computeCellDimensions];
    
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

-(void) updateSpotSize:(float)value{
    //TODO:adjust spot size accordingly to changes to pitches
}


//Printing actions
- (IBAction)PrintButtonPushed:(id)sender {
    GridMatrix* grid = model.getGridMatrix;
    for(int i=0;i<model.getGridMatrix.getRows;i++){
        for(int j=0;j<model.getGridMatrix.getColumns;j++){
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
    _ConnectedDeviceImage.image = [UIImage imageNamed:@"Arduino.png"];
    
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
    
    rowSlider.value = rowStepper.value = model.getGridMatrix.getRows;
    columnSlider.value = columnStepper.value = model.getGridMatrix.getColumns;
    NSString *newText = [[NSString alloc] initWithFormat:@"%d",
                         model.getGridMatrix.getColumns];
    columnLabel.text = newText;
    newText = [[NSString alloc] initWithFormat:@"%d",
               model.getGridMatrix.getRows];
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
    
    rowSlider.value = rowStepper.value = model.getGridMatrix.getRows;
    columnSlider.value = columnStepper.value = model.getGridMatrix.getColumns;
    NSString *newText = [[NSString alloc] initWithFormat:@"%d",
                         model.getGridMatrix.getColumns];
    columnLabel.text = newText;
    newText = [[NSString alloc] initWithFormat:@"%d",
                         model.getGridMatrix.getRows];
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

//=============================================================================================
//=============================================================================================
//=============================================================================================
//=============================================================================================
//
//                                          Grid View
//
//=============================================================================================
//=============================================================================================
//=============================================================================================
//=============================================================================================

-(NSInteger)computeCellDimensions{
//    NSInteger maxVertical = GRID_DISPLAY_HEIGHT/(self.cellsPerRow);
    NSInteger maxHorizontal = (GRID_DISPLAY_WIDTH/self.cellsPerColumn) - self.cellSpacing;
    if(self.cellsPerColumn == 2)
        return 170;
    
    if(self.cellsPerColumn == 3)
        return 120;
    
    if(self.cellsPerColumn == 4)
        return 90;
    
    if(self.cellsPerColumn == 5)
        return 65;
    
    if(self.cellsPerColumn == 6)
        return 55;
    
    if(self.cellsPerColumn == 7)
        return 45;
    
    if(self.cellsPerColumn == 8)
        return 40;
    
    if(self.cellsPerColumn == 9)
        return 35;

    if(self.cellsPerColumn == 10)
        return 33;
    
    return maxHorizontal;
}
/*
 *  updating cell height/width when the rows/columns sliders change.
 */
-(void) updateCellDimensions {
    self.cellsPerColumn = model.gridMatrix.getColumns;
    self.cellsPerRow =  model.gridMatrix.getRows;
    
    self.cellDimension = [self computeCellDimensions];
}




- (void)updateGridViewColumns:(NSInteger)oldNrOfCols newNrOfCols:(NSInteger)newNrOfCols oldNrOfRows:(NSInteger)oldNrOfRows {
    if(newNrOfCols == oldNrOfCols) {
        return;
    }
    [self changeValueSlider:columnSlider :columnLabel :columnStepper];
    
    NSInteger maxNumOfCols = model.device.getNumberOfPrintableColumns;
    if((model.device != nil) && (newNrOfCols > maxNumOfCols)) {
        NSLog(@"GRIDLOG: maxnumber of cols exceeded: newRows=%d / maxrows=%d", newNrOfCols, maxNumOfCols);
        //TODO: display error;
        return;
    } else {
        //Create new matrix;
        NSLog(@"GRIDLOG: ROWS=%d->%d ;;;;  COL=%d->%d", oldNrOfRows, oldNrOfRows, oldNrOfCols, newNrOfCols);
        dispatch_async(dispatch_get_main_queue(), ^{
            GridMatrix *newMat = [model.gridMatrix newMatrix:oldNrOfRows :newNrOfCols];
            [model setGridMatrix:newMat];
            [self updateCellDimensions];
            [self.gridView reloadData];
        });
    }
}

- (IBAction)columnSliderChanged:(id)sender {
    
    [self updateCellDimensions];
    
    NSInteger newNrOfCols = floor(columnSlider.value);
    NSInteger oldNrOfCols = [model.gridMatrix getColumns];
    NSInteger oldNrOfRows = [model.gridMatrix getRows];
    
    [self updateGridViewColumns:oldNrOfCols newNrOfCols:newNrOfCols oldNrOfRows:oldNrOfRows];
}

- (IBAction) columnStepperChanged:(id)sender {
    //TODO: update like the slider counterpart
    [self changeValueStepper:columnSlider :columnLabel :columnStepper];
    [self updateCellDimensions];
}

- (void)updateGridViewRows:(NSInteger)oldNrOfRows newNrOfRows:(NSInteger)newNrOfRows oldNrOfCols:(NSInteger)oldNrOfCols {
    //this is necessary because the slider changes by float values.
    if(newNrOfRows == oldNrOfRows) {
        return;
    }
    [self changeValueSlider:rowSlider :rowLabel :rowStepper];
    
    NSInteger maxNumOfRows = model.device.getNumberOfPrintableRows;
    if((model.device != nil) && (newNrOfRows > maxNumOfRows)) {
        NSLog(@"GRIDLOG: maxnumber of rows exceeded: newRows=%d / maxrows=%d", newNrOfRows, maxNumOfRows);
        //TODO: display error;
        return;
    } else {
        //Create new matrix;
        NSLog(@"GRIDLOG: ROWS=%d->%d ;;;;  COL=%d->%d", oldNrOfRows, newNrOfRows, oldNrOfCols, oldNrOfCols);
        dispatch_async(dispatch_get_main_queue(), ^{
            GridMatrix *newMat = [model.gridMatrix newMatrix:newNrOfRows :oldNrOfCols];
            [model setGridMatrix:newMat];
            [self updateCellDimensions];
            [self.gridView reloadData];
        });
    }
}

- (IBAction)rowSliderChanged:(id)sender {
    NSInteger newNrOfRows = floor(rowSlider.value);
    NSInteger oldNrOfCols = [model.gridMatrix getColumns];
    NSInteger oldNrOfRows = [model.gridMatrix getRows];
    
    [self updateGridViewRows:oldNrOfRows newNrOfRows:newNrOfRows oldNrOfCols:oldNrOfCols];
}

- (IBAction) rowStepperChanged:(id)sender {
    //TODO: update like the slider counterpart
    [self changeValueStepper:rowSlider :rowLabel :rowStepper];
    [self updateCellDimensions];
}


#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    GridMatrix *mat = model.gridMatrix;
    if(mat != nil){
        NSInteger total = self.cellsPerRow * self.cellsPerColumn;
        NSLog(@"GRIDLOG:numberOfItemsInSection;;;; amount of items =%d", total);
        return total;
    } else {
        [NSException raise:@"Model not initialized properly" format:@"Model grid matrix not initialized properly when trying to display grid"];
    }
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    //this number is always 1.
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    GridCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"GridCell" forIndexPath:indexPath];
    NSUInteger array[[indexPath length]];
    [indexPath getIndexes: array];
    //array[0] will always be 0 since we have only one section.
    NSInteger linearIndex = array[1];
    
    if([model.gridMatrix isMarked:linearIndex] == NO){
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [UIColor blackColor];
    }
    return cell;
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blackColor];
    NSUInteger array[[indexPath length]];
    [indexPath getIndexes: array];
    //array[0] will always be 0 since we have only one section.
    NSInteger linearIndex = array[1];

    NSLog(@"DEBUG: TOUCH index=%d!", linearIndex);
    [model.gridMatrix flip:linearIndex];
    [cv reloadData];

}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}



#pragma mark – UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize retval = CGSizeMake(self.cellDimension, self.cellDimension);
    return retval;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(self.cellSpacing, self.cellSpacing, self.cellSpacing, self.cellSpacing);
}


//=============================================================================================
//=============================================================================================
//=============================================================================================
//=============================================================================================
//
//                                      END Grid View
//
//=============================================================================================
//=============================================================================================
//=============================================================================================
//=============================================================================================

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
