//
//  IWMapVC.h
//  IWShopping0221
//
//  Created by s on 17/2/22.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface IWMapVC : UIViewController<BMKMapViewDelegate, BMKGeoCodeSearchDelegate> {
    BMKMapView* _mapView;
    BMKGeoCodeSearch* _geocodesearch;
    NSString *_coordinateX;
    NSString *_coordinateY;
    NSString *_locationName;
}

-(instancetype)initWithCoordinateX:(NSString *)coordinateX coordinateY:(NSString *)coordinateY locationName:(NSString *)locationName;
@end
