## MLChoiceImageView
图片选择器,多图片选择器,图片浏览器
## <a id="图片浏览"></a>图片浏览
- 相册选择界面

![(App)](http://a3.qpic.cn/psb?/V13XLmNA0zbAmP/h*c5kljL6Eu4G7mrHODX1.w5yWHcJ*D5cler106x55s!/b/dMIJTm62GwAA&bo=gAJwBAAAAAAFB9I!&rf=viewer_4)
- 照片选择界面

![(App)](http://a2.qpic.cn/psb?/V13XLmNA0zbAmP/i55cWgi.JmfWdyBWaGcjsQkXO.wvTVVR6smtKfFbZEs!/b/dHYCt20fAwAA&bo=gAJwBAAAAAAFB9I!&rf=viewer_4)
- 照片浏览界面(支持手势放大缩小)

![(App)](http://a2.qpic.cn/psb?/V13XLmNA0zbAmP/qBg9R2HNls*XIUx7YUwTMqUS3TcnWJxOTtseEjUTJr4!/b/dJOLd2.hKwAA&bo=gAJwBAAAAAAFB9I!&rf=viewer_4)
## <a id="基本使用"></a>基本使用
```objc
    //创建控制器
    MLAssetPickerController *pc = [[MLAssetPickerController alloc] init];
   //最多选择照片的数量
    pc.SelectNumber = 6;
    //遵循代理
    pc.delegate = self;
    //创建NavigationController
    UINavigationController* uc = [[UINavigationController alloc]initWithRootViewController:pc];
    //模态出控制器
    [self presentViewController:uc animated:YES completion:NULL];
//实现代理方法
-(void)assetPickerController:(MLAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    //在这里退出模态窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    //取得Asset照片属性,自己转换便可
    NSLog(@"有几张照片%lu",(unsigned long)assets.count);
}
```
