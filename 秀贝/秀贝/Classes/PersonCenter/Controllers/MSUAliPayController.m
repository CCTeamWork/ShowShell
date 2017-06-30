//
//  MSUAliPayController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/6/30.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUAliPayController.h"

// 支付类
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "RSADataSigner.h"

@implementation MSUAliPayController


#pragma mark - AppDelegate 中 - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
+ (void)appDelegatePaySomethingWithurl:(NSURL *)url{
    NSLog(@"走到 AppDelegate openURL 方法中");
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
}


#pragma mark - 随机方法
+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

#pragma mark   ==============点击订单模拟支付行为==============
+ (void)payForSomethingWithAliPay{
    NSString *appID = @"2017061507498714";
    NSString *rsa2PrivateKey = @"MIIEpAIBAAKCAQEAwfHlEP0BfZBUXkxk0eLgf2KGk8c7pp2MaR4Qt0wLhlITVtIzKv4U12ZUrUT0hChNR1egLaofpAI8FarrUC2z4af2oA3tdZfuBU3F1W00YBd4FP2VWAwtQ0UGadq7NtlzAJ1jB0Bj7RTjZNtGk4UldQWcX+0XJCnwI3mL2agIZd/3d/iNOcGjWmeQ6+7LYF8sZ94YXySaskTqPNKHguzExLBbEq+9x84nZxH4Kbeh+E0cemZItgX9m/HpU4BpsDz2XFS0tcg3qMu5eOQWMRCbIQDfnYTLp65ehdPwJxi/eioY0I64R4iJDStQ92f2QfdMhhQbOabttxAZ4632Y9OJUQIDAQABAoIBAHpbI4reM4yF+9QqGgkYO03iWMjujsGE78p5f05EmZi6Ox0xK7rZ5UgndRCDSkf+LRLvQ0zL4X5VMpbw59gDnVKl5r//SWpA2ZdbA46sgLiG1elYOln8BKpF58/sgOQPt7ARmyI+C0zNOtCsThBPldwIGCmkqE7WbnvS+NnuWq35zMNJS7JpqYt0VhfJuT2L1ZND+pgVlCJjhlB66A1o3iI2VsTf++0T5Kq7mv/GNUixgiftbu5Dn79vJeyZqTGO6mj+4Y+1LZU5ntCYiG8srV4weZDUT33vCeG0UomWvvU2w9F6VRsDDgqrxCPoDhPOVuhDjyUiBFcfRAK0KpPvlAECgYEA/mwBmXTx5CnnGwY9SeMC3biO8oL4j0dnZ3hcrO+4NDW3e0qdGUZ6+1imels/zaz7+l1EdaqLuMe+hNdXfWKJiBTvf/q4Bc6euWPU3i76FJnFUoJ91+AejP+IBkExFU9ovC4AXpNR2UMX4zKl63fjjx3g9S1LeKAvQNud5C2jk/ECgYEAwyXbl2dPJYF6GSuZJ2Svtt8AAc/WU3a0sOuCfm3NU/KqzcGd0EYI5gy1lRdJbChN7uAMP1OIWT4PX5uHggwX7xDWweWO5IdGRj6liIa0zjW23Znxwy+aXsORXr9ZB8wi37xJocEKrqoHcvi6v5x3gfnP6Zng+jcW99qNlJHvK2ECgYAcGUWb8yR79HzHqUq/jEjWv/lZo0lcWaB79vkVSGxpp70Z6sWq8vPGKqZIQSesyXwSzJYxAKLpx3WtKjNJb8aMtvM0iTYlvgodo37xAvMvr0PxtuO7Ic999wLI3g5Tsi95CQOVbmPNwPE0cHWOqfEB72TW7ye0rMxLN3Yaq0ezoQKBgQCRFxabDO5lfkyfZjDqfwu9tTM2Jaa+S2WwnIlbIpwkrCmd7TQ+Y7O+BvkCrluilJzM27t/YcXgRCn99Y7ce81Xq3dgliKVepYfJ/i+9xh6sKkTPZ/odP4bMuBkR3QUPgw3uLAuGW6tyjDbpF6Ek/quomOY1RXWMxtakB3vtkjSQQKBgQCiltXUrIvmBTzR3D8W7QNAd1RGMgJ9och/mHg0zfCIHEl3XVTEqLPni0eO9lxStZnQKSc60xm1/pAb9Cg5Oz1yKwqi3tWGFFRQUqnwep4H8jizbXFLlTmYul+T1fqNbAKgsXYoa8o2IjaDaASxSLWolOHyt4FT7vdP01atlMBVew==";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"scheme";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }

}

@end
