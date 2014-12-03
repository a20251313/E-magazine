//
//  BATestViewController.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFGraphViewController1.h"
#import "BADocumentButton.h"
#import "BAColorHelper.h"
#import "BADefinition.h"
#import "BATestCell.h"
#import "BAMixGraph2.h"
#import "BFGraph1Model.h"
#import "BFAppDelegate.h"
#import "Global.h"
@interface BFGraphViewController1 ()

@property(nonatomic)NSUInteger dataType;
@end

@implementation BFGraphViewController1
{
    BADocument *document;
    BAMixGraph2 *graph;
    CGPoint originalPosition;
    BAReport *myReport;
    NSUInteger flag;
    BFGraph1Model *curModel;
    NSUInteger curRect;
    NSUInteger curCompany;
    //当前的月份
    NSUInteger curIndex;
    NSMutableArray *models;
    NSMutableArray *productNameArray;
    NSMutableArray *rects;
    NSMutableArray *tableCellValues;
    NSMutableArray *itemsArray;
    //NSUInteger selectedButton;
}
@synthesize scrollView;
@synthesize hostView;
@synthesize host;
@synthesize myTableView;
@synthesize curValueLabel;
@synthesize compareValueLabel;
@synthesize diversityValueLabel;
@synthesize diversityRatioLabel;
@synthesize mySlider;
@synthesize bar;
@synthesize curItemLabel;
@synthesize compareItemLabel;
@synthesize productNameLabel;
@synthesize rectNameLabel;
@synthesize button;
@synthesize dataType;
#pragma mark - custom method

/*
 *
 *
 *  @param type 1是读取magazine.json 数据   2是读取magazine_ansheng.json数据，3是读取magazine_yusuan.json数据
 *
 *  @return <#return value description#>
 */
-(id)initWithType:(NSUInteger)type
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.dataType = type;
        
    }
    return self;
}
-(void)reloadDocument//4
{
    [self reloadTableCells];
    [self reloadRects];
    [self renderGraph];
    [self reloadItems];
}
-(void)reloadTableCells
{
    //NSMutableArray *cellValues=[[NSMutableArray alloc]init];
    tableCellValues=[[NSMutableArray alloc]init];
    for (int i=0; i<[productNameArray[curRect] count]; i++) {
        BFGraph1Model *model=[models objectAtIndex:curRect];
        BAReport *report=[model.reports objectAtIndex:i];
        NSMutableArray *values;
        if (0) {
            BAMetric *metric=[report.reportData.metrics objectAtIndex:0];
            double curValue=[[metric.dataValues objectAtIndex:curIndex]doubleValue];
            NSString *curString=[NSString stringWithFormat:@"%.1f",curValue];
            NSString *preString;
            NSString *colorString;
            
            if (0<curIndex) {
                double preValue=[[metric.dataValues objectAtIndex:curIndex-1]doubleValue];
                preString=[NSString stringWithFormat:@"%.1f",preValue];
                double diversityValue=curValue-preValue;
                if (diversityValue>0) {
                    colorString=@"00ff00";
                }else{
                    colorString=@"ff0000";
                }
            }else
            {
                preString=@"-";
                colorString=@"00ff00";
            }
            values=[NSMutableArray arrayWithObjects:preString,curString,colorString, nil];
            
        }else
        {
            BAMetric *metric1=[report.reportData.metrics objectAtIndex:0];
            BAMetric *metric2=[report.reportData.metrics objectAtIndex:1];
            double curValue=[[metric1.dataValues objectAtIndex:curIndex] doubleValue];
            double compareValue=[[metric2.dataValues objectAtIndex:curIndex]doubleValue];
            double diversityValue=curValue-compareValue;
            NSString *curString=[NSString stringWithFormat:@"%.1f",curValue];
            NSString *compareValueString=[NSString stringWithFormat:@"%.1f",compareValue];
            NSString *colorString;
            if (diversityValue>0) {
                colorString=@"00ff00";
            }else{
                colorString=@"ff0000";
            }
            values=[NSMutableArray arrayWithObjects:compareValueString,curString,colorString, nil];
        }
        //[cellValues addObject:values];
        [tableCellValues addObject:values];
    }
    [myTableView reloadData];
}
-(void)reloadLabels
{
    BAReport *report=[curModel.reports objectAtIndex:curCompany];
    if (0) {
        BAMetric *metric=[report.reportData.metrics objectAtIndex:0];
        double curValue=[[metric.dataValues objectAtIndex:curIndex] doubleValue];
        if (0<curIndex) {
            double preValue=[[metric.dataValues objectAtIndex:curIndex-1] doubleValue];
            compareValueLabel.text=[NSString stringWithFormat:@"%.1f", preValue];
            double diversityValue=curValue-preValue;
            double diversityRatio=diversityValue/curValue;
            if (diversityValue>=0) {
                diversityValueLabel.textColor=[UIColor greenColor];
                diversityRatioLabel.textColor=[UIColor greenColor];
                graph->isPositive=YES;
            }else
            {
                diversityValueLabel.textColor=[UIColor redColor];
                diversityRatioLabel.textColor=[UIColor redColor];
                graph->isPositive=NO;
            }
            diversityValueLabel.text=[NSString stringWithFormat:@"%.1f", diversityValue];
            
            diversityRatioLabel.text=[NSString stringWithFormat:@"%.1f%%", diversityRatio*100];
        }else
        {
            diversityValueLabel.textColor=[UIColor whiteColor];
            diversityRatioLabel.textColor=[UIColor whiteColor];
            diversityValueLabel.text=@"-";
            diversityRatioLabel.text=@"-";
        }
        curValueLabel.text=[NSString stringWithFormat:@"%.1f", curValue];
    }else
    {
        BAMetric *metric1=[report.reportData.metrics objectAtIndex:0];
        BAMetric *metric2=[report.reportData.metrics objectAtIndex:1];
        double curValue=[[metric1.dataValues objectAtIndex:curIndex] doubleValue];

        double compareValue=[[metric2.dataValues objectAtIndex:curIndex] doubleValue];
        compareValueLabel.text=[NSString stringWithFormat:@"%.1f", compareValue];
        double diversityValue=curValue-compareValue;
        double diversityRatio=diversityValue/curValue;
        if (diversityValue>=0) {
            diversityValueLabel.textColor=[UIColor greenColor];
            diversityRatioLabel.textColor=[UIColor greenColor];
            graph->isPositive=YES;
        }else
        {
            diversityValueLabel.textColor=[UIColor redColor];
            diversityRatioLabel.textColor=[UIColor redColor];
            graph->isPositive=NO;
        }
        diversityValueLabel.text=[NSString stringWithFormat:@"%.1f", diversityValue];
        
        diversityRatioLabel.text=[NSString stringWithFormat:@"%.1f%%", diversityRatio*100];

        curValueLabel.text=[NSString stringWithFormat:@"%.1f", curValue];
    }
}

-(void)reloadRects
{
    
    NSString   *strCompany = [productNameArray[curRect] objectAtIndex:curCompany];
    for (int i=0; i<rects.count; i++) {
        BADocumentButton *rect=[rects objectAtIndex:i];
    
        BAReport *report = nil;
        
        for (int index = 0;index < [productNameArray[i] count];index++)
        {
            NSString *currentCompany = productNameArray[i][index];
            if ([currentCompany isEqualToString:strCompany])
            {
                report =   [[models[i] reports] objectAtIndex:index];
                break;
            }
        }
        
        if (report == nil)
        {
            rect.arrow.image=nil;
            rect.dataValue.text = @"";
            rect.ratioLebel.text = @"";
            rect.entity.text = @"";
#if DEBUG
            NSLog(@"%@ 没有%@的数据",strCompany,itemsArray[curRect]);
#endif
            continue;
        }
        
       
        if (0) {
            BAMetric *metric=[report.reportData.metrics objectAtIndex:0];
            double curValue=[[metric.dataValues objectAtIndex:curIndex] doubleValue];
            if (curIndex>0) {
                double preValue=[[metric.dataValues objectAtIndex:curIndex-1] doubleValue];
                
                rect.dataValue.text=[NSString stringWithFormat:@"%.1f",preValue];
                double diversityValue=curValue-preValue;
                if (diversityValue>=0) {
                    rect.arrow.image=[UIImage imageNamed:@"arrow-up01"];
                    rect.dataValue.textColor=[UIColor greenColor];
                    rect.ratioLebel.textColor=[UIColor greenColor];
                }else
                {
                    rect.arrow.image=[UIImage imageNamed:@"arrow-down01"];
                    rect.dataValue.textColor=[UIColor redColor];
                    rect.ratioLebel.textColor=[UIColor redColor];
                }
                rect.ratioLebel.text=[NSString stringWithFormat:@"%.1f%%",diversityValue/curValue*100];
            }else
            {
                
            }
            rect.entity.text=[NSString stringWithFormat:@"%.1f",curValue];
        }else
        {
            BAMetric *metric1=[report.reportData.metrics objectAtIndex:0];
            double curValue=[[metric1.dataValues objectAtIndex:curIndex] doubleValue];
            BAMetric *metric2=[report.reportData.metrics objectAtIndex:1];
            double compareValue=[[metric2.dataValues objectAtIndex:curIndex] doubleValue];
            rect.entity.text=[NSString stringWithFormat:@"%.1f",curValue];
            rect.dataValue.text=[NSString stringWithFormat:@"%.1f",compareValue];
            double diversityValue=curValue-compareValue;
            if (diversityValue>=0) {
                rect.arrow.image=[UIImage imageNamed:@"arrow-up01"];
                rect.dataValue.textColor=[UIColor greenColor];
                rect.ratioLebel.textColor=[UIColor greenColor];
            }else
            {
                rect.arrow.image=[UIImage imageNamed:@"arrow-down01"];
                rect.dataValue.textColor=[UIColor redColor];
                rect.ratioLebel.textColor=[UIColor redColor];
            }
            rect.ratioLebel.text=[NSString stringWithFormat:@"%.1f%%",diversityValue/curValue*100];
            
        }
    }
}

-(void)reloadItems
{
    productNameLabel.text=curModel.name;
    switch (curRect) {
        case 0:
        {
            curItemLabel.text=@"本期";
            compareItemLabel.text=@"同期";
            rectNameLabel.text=@"销量";
        }
            break;
        case 1:
        {
            curItemLabel.text=@"本期";
            compareItemLabel.text=@"同期";
            rectNameLabel.text=@"销量达成";
        }
            break;
        case 2:
        {
            curItemLabel.text=@"本期";
            compareItemLabel.text=@"同期";
            rectNameLabel.text=@"销量环比";
        }
            break;
        case 3:
        {
            curItemLabel.text=@"本期";
            compareItemLabel.text=@"同期";
            rectNameLabel.text=@"利润率";
        }
            break;
        case 4:
        {
            curItemLabel.text=@"本期";
            compareItemLabel.text=@"同期";
            rectNameLabel.text=@"利润率达成";
        }
            break;
        case 5:
        {
            curItemLabel.text=@"本期";
            compareItemLabel.text=@"同期";
            rectNameLabel.text=@"市场占有率";
        }
            break;
        default:
        {
            curItemLabel.text=@"";
            compareItemLabel.text=@"";
        }
            break;
    }
    
    rectNameLabel.text = itemsArray[curRect];
    productNameLabel.text = productNameArray[curRect][curCompany];
}
-(void)selectRect:(BADocumentButton*)sender
{
    if (curRect != sender.selectedButtonIndex)
    {
        curCompany = 0;
        curIndex = 0;
    }
    curRect=sender.selectedButtonIndex;
    curModel = models[curRect];
    for (id view in sender.superview.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *but=(UIButton*)view;
            [but setHighlighted:NO];
        }
    }
    [self performSelector:@selector(highlightButton:) withObject:sender afterDelay:0.0];
    [self reloadDocument];
    //[sender setHighlighted:YES];
}
-(void)highlightButton:(UIButton*)sender
{
    [sender setHighlighted:YES];
    
}
- (IBAction)sliderAction:(UISlider *)sender {
    [self reloadTableCells];
    float sliderRange = sender.frame.size.width - sender.currentThumbImage.size.width;
    float sliderOrigin = sender.frame.origin.x + (sender.currentThumbImage.size.width / 2.0);
    
    float sliderValueToPixels = ((((sender.value-sender.minimumValue)/(sender.maximumValue-sender.minimumValue)) * sliderRange) + sliderOrigin);
    /*CGRect barFrame=bar.frame;
    barFrame.origin.x=sliderValueToPixels;
    bar.frame=barFrame;*/
    CGPoint barCenter=bar.center;
    barCenter.x=sliderValueToPixels;
    bar.center=barCenter;
    
    CPTXYPlotSpace *plotSpace=(CPTXYPlotSpace*)[graph.graph plotSpaceAtIndex:0];
    NSDecimal d[2];
    [plotSpace plotPoint:d forPlotAreaViewPoint:barCenter];
    NSDecimalNumber *x=[[NSDecimalNumber alloc]initWithDecimal:d[0]];
    //NSDecimalNumber *y=[[NSDecimalNumber alloc]initWithDecimal:d[1]];
    //NSLog(@"%f----%d",[x doubleValue],[y intValue]);
    int selectedIndex=round([x doubleValue])-2; //[x intValue]-2;
    if (selectedIndex<0) {
        selectedIndex=0;
        
    }else if (selectedIndex>11)
    {
        selectedIndex=11;
    }
    //NSLog(@"%d",selectedIndex);
    curIndex=selectedIndex;
    if (graph->selectedIndex!=selectedIndex) {

        [self reloadLabels];
        [self reloadRects];
        [self reloadTableCells];
        graph->selectedIndex=selectedIndex;
        [graph.graph reloadData];
        
    }
    
    //curIndex=selectedIndex;
    
}

-(void)renderGraph
{
    graph=[[BAMixGraph2 alloc]init];

    [graph configurePlots:[curModel.reports objectAtIndex:curCompany]];
    
    [graph renderInHostView:[self hostView]];
}


-(void)backAction
{
    BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
    [self.navigationController.view.layer addAnimation:animation.showNavigationController forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
    document=nil;
    graph=nil;

    myReport=nil;

}


-(void)showGraph:(BADocumentButton*)sender
{
    //int index=sender.selectedButtonIndex
    [self renderGraph];
    originalPosition=host.center;

    CGPoint point=[self.view convertPoint:sender.center fromView:scrollView];
    host.center=point;
    CGAffineTransform newTransform = CGAffineTransformMakeScale( 0 , 0);
    [host setTransform :newTransform];
    mySlider.alpha=0;
    bar.alpha=0;
    curValueLabel.alpha=0;
    compareValueLabel.alpha=0;
    diversityValueLabel.alpha=0;
    [UIView animateWithDuration:0.5 animations:^
    {
        
        host.center=CGPointMake(originalPosition.x,originalPosition.y);
        CGAffineTransform newTransform = CGAffineTransformMakeScale( 1 ,1);
        [host setTransform :newTransform];
        
    }completion:^(BOOL finished)
     {
         mySlider.alpha=1;
         bar.alpha=1;
         curValueLabel.alpha=1;
         compareValueLabel.alpha=1;
         diversityValueLabel.alpha=1;
     }];
    
    [self reloadTableCells];
}
- (IBAction)backAction:(UIBarButtonItem *)sender {
  //  [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView setTableFooterView:v];
    BATestCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];    
    if (cell==nil) {
        cell=(BATestCell*)[[[NSBundle mainBundle]loadNibNamed:@"BATestCell" owner:self options:nil]lastObject];
    }

    cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"table-selected"]];
    [cell setBackgroundView:[UIView new]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    if (indexPath.row<[productNameArray[curRect] count]) {

        cell.name.text=[productNameArray[curRect] objectAtIndex:indexPath.row];

        cell.entity.text=[[tableCellValues objectAtIndex:indexPath.row] objectAtIndex:0];
        cell.value.text=[[tableCellValues objectAtIndex:indexPath.row] objectAtIndex:1];
        cell.value.textColor=[BAColorHelper stringToUIColor:[[tableCellValues objectAtIndex:indexPath.row] objectAtIndex:2] alpha:@"1"];
    }else {
        cell.entity.text=nil;
        cell.value.text=nil;
        cell.name.text=nil;
    }
    
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    //NSUInteger extra=(int) tableView.frame.size.height/40;
    return [productNameArray[curRect] count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    curCompany = indexPath.row;
    [self reloadDocument];
  //  curModel=[models objectAtIndex:indexPath.row];
 /*   [self renderGraph];
    [self reloadRects];
    [self reloadItems];*/
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - system method
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    //NSArray *nameArray=[NSArray arrayWithObjects:@"机组统计台数",@"非停次数",@"台平均非停运次数",@"等效可用系数",@"计划停运系数",@"非计划停运系数",nil];
    NSArray *nameArray = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"companyName" ofType:@"txt"];
    BADocumentService *documentService=[[BADocumentService alloc]init];
    BADataSourceService *dataSourceService=[[BADataSourceService alloc]init];
    //从数据源获取document
   
    if(self.dataType == 1)
    {
      nameArray =   [NSArray arrayWithObjects:@"发电量",@"利用小时",@"供电耗煤",@"标煤采购单价",@"销售收入",@"利润",nil];
     document = [documentService getDocumentWithDictionary:[dataSourceService getDocumentDictionaryMagazine:@"000000" fileName:@"magazine"]];
    }else if (self.dataType == 2)
    {
        nameArray =   [NSArray arrayWithObjects:@"供电煤耗",@"厂用电率",nil];
        filePath = [[NSBundle mainBundle] pathForResource:@"companyName2" ofType:@"txt"];
        document = [documentService getDocumentWithDictionary:[dataSourceService getDocumentDictionaryMagazine:@"000000" fileName:@"magazine_ansheng"]];
    }else if (self.dataType == 3)
    {
        nameArray =   [NSArray arrayWithObjects:@"发电量",@"标煤采购单价",@"含税电价",@"管理费用",@"财务费用",@"利润",nil];
        filePath = [[NSBundle mainBundle] pathForResource:@"companyName3" ofType:@"txt"];
         document = [documentService getDocumentWithDictionary:[dataSourceService getDocumentDictionaryMagazine:@"000000" fileName:@"magazine_yusuan"]];
    }
    itemsArray = [[NSMutableArray alloc] initWithCapacity:nameArray.count];
    [itemsArray addObjectsFromArray:nameArray];
    
  
   // productNameArray=[NSArray arrayWithObjects:@"股份",@"北方",@"呼伦贝尔",@"吉林",@"黑龙江",nil];
    productNameArray = [[NSMutableArray alloc] init];
    
    
    NSString    *strCompanys = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    strCompanys = [strCompanys stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    strCompanys = [strCompanys stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    strCompanys = [strCompanys stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
     NSArray *array = [strCompanys componentsSeparatedByString:@";"];
    for (NSString *strTemp in array)
    {
        NSArray *arrSubCompanys = [strTemp componentsSeparatedByString:@","];
        if (arrSubCompanys.count < 2)
        {
            continue;
        }
        [productNameArray addObject:arrSubCompanys];
        
    }

   
    
    
    curRect=0;
    curIndex=0;
    curCompany = 0;
    models=[[NSMutableArray alloc]initWithCapacity:5];
    int count = 0;
    for (int i = 0;i < nameArray.count;i++)
    {
         NSMutableArray *productReports=[[NSMutableArray alloc]initWithCapacity:10];
        for (int j = 0;j<[productNameArray[i] count];j++)
        {
            [productReports addObject:[document.reports objectAtIndex:count]];
            count++;
        }
        BFGraph1Model *model=[[BFGraph1Model alloc] initWithReports:productReports];
        model.name=[productNameArray[i] objectAtIndex:i];
        [models addObject:model];
    }
    
    curModel=[models objectAtIndex:0];
    rects=[[NSMutableArray alloc] init];
    scrollView.layer.masksToBounds=NO;
    for (int i=0; i<nameArray.count;i++) {
        BADocumentButton *documentButton=[[[NSBundle mainBundle] loadNibNamed:@"documentButton" owner:self options:nil]lastObject];
        if (i==0) {
            [documentButton setHighlighted:YES];
        }
        //documentButton.selectedButtonIndex=i;
        documentButton.frame=CGRectMake((211+10)*i, 2, 211, 158);
        [documentButton addTarget:self action:@selector(showGraph:) forControlEvents:UIControlEventTouchUpInside];
        documentButton.selectedButtonIndex=i;
        UIImage *backImage=[UIImage imageNamed:@"btn01"];
        UIImage *linkImage=[UIImage imageNamed:@"btn-selected01"];
        [documentButton setImage:backImage forState:UIControlStateNormal];
        [documentButton setImage:linkImage forState:UIControlStateHighlighted];
        documentButton.metric.text=[nameArray objectAtIndex:i];
        
        [documentButton addTarget:self action:@selector(selectRect:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:documentButton];
        [rects addObject:documentButton];
    }
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction)];
    UIBarButtonItem *home=[[UIBarButtonItem alloc]initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(backHome)];
    [self navigationItem].leftBarButtonItems=[NSArray arrayWithObjects:home,back, nil];
    
    UIBarButtonItem *next=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextController)];
    [self navigationItem].rightBarButtonItem=next;

    scrollView.contentSize=CGSizeMake(221*nameArray.count, 138);
    [mySlider setThumbImage:[UIImage imageNamed:@"graph1-thumb" ] forState:UIControlStateNormal];
    [mySlider setThumbImage:[UIImage imageNamed:@"graph1-thumb-selected"] forState:UIControlStateHighlighted];
    
    [self reloadDocument];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 
    }
    return self;
}
- (void)viewDidUnload
{
//    [self setDocument:nil];
    [self setScrollView:nil];
    [self setHostView:nil];
    [self setHost:nil];
    [self setMyTableView:nil];
    [self setCurValueLabel:nil];
    [self setCompareValueLabel:nil];
    [self setDiversityValueLabel:nil];
    [self setDiversityRatioLabel:nil];
    [self setMySlider:nil];
    [self setBar:nil];
    [self setCurItemLabel:nil];
    [self setCompareItemLabel:nil];
    [self setProductNameLabel:nil];
    [self setRectNameLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
-(BOOL)shouldAutorotate{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations{
     return UIInterfaceOrientationMaskLandscape;
}

@end
