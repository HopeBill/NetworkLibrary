//
//  RequestAPIHeader.h
//  OneKeyBrother
//
//  Created by Bill on 9/4/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#ifndef RequestAPIHeader_h
#define RequestAPIHeader_h


#define Environment  0
#define BASED_URL  Environment?Formal_URL:Test_URL
#define Formal_URL @"http://47.107.83.176?"  //正式
#define Test_URL   @"http://47.107.83.176"  //测试


#define GetURL(api) [BASED_URL stringByAppendingString:api]

/**
 *获取验证码
 **/
#define  Codegetcode_user_URL GetURL(@"/user/user/user/codegetcode")
/**
 *获取图像验证码
 **/
#define  GraphicCodegetcode_user_URL GetURL(@"/user/user/user/codegetcode")
/**
 *验证码是否正确
 **/
#define userCodeisCode_URL GetURL(@"/user/user/user/codeisCode")
/**
 *验证手机号码
 **/
#define  MyisCallPhone_URL  GetURL(@"/user/user/user/isCallPhone")


/**
 *手机号码登录
 **/
#define Login_URL  GetURL(@"/user/user/login/login")
/**
 *GW密码登录
 **/
#define GWLogin_URL  GetURL(@"/user/user/login/passwordlogin")

/**
 *记录推荐人
 **/
#define recordReferrer_URL  GetURL(@"/user/user/merchant/markReferee")


/**
 *修改登录密码
 **/
#define ModifyLoginPassword_URL  GetURL(@"/user/user/login/changePassword")

/**
 *获取我的个人信息
 **/
#define MyDetail_URL  GetURL(@"/user/user/user/myDetail")
/**
 *获取我的个人资料
 **/
#define MyProfile_URL  GetURL(@"/user/user/user/myProfile")
/**
 *获取我的二维码
 **/
#define MyQrCode_URL  GetURL(@"/user/user/user/myQrCode")
/**
 *修改我的个人资料
 **/
#define modifyMyProfile_URL  GetURL(@"/user/user/user/changeProfile")
/**
 *修改新手机号码
 **/
#define userUserChangePhone_URL  GetURL(@"/user/user/user/changePhone")

/**
 *上传照片
 **/
#define updatePicture_URL  GetURL(@"/upload/saveUploaderPhoto")


/**
 *上传用户图像
 **/
#define updateImage_URL  GetURL(@"/user/user/user/uploadProfilePicture")

/**
 *保存门店信息
 **/
#define saveStoreInformation_URL  GetURL(@"/merchant/user/merchant/saveStoreInformation")

/**
 *保存资质信息
 **/
#define saveQualificationInformation_URL  GetURL(@"/merchant/user/merchant/saveQualificationInfo")
/**
 *资质信息:行业许可证类型
 **/
#define merchantListTradelicense_URL  GetURL(@"/merchant/merchant/merchant/listTradelicense")
/**
 *保存收款信息
 **/
#define saveReceivablesInformation_URL  GetURL(@"/merchant/user/merchant/saveReceivablesInfo")

/**
 *门店详情回填
 **/
#define storeInformationFileInformation_URL  GetURL(@"/merchant/user/merchant/storeInformationFile")
/**
 *资质信息回填
 **/
#define qualificationsInformation_URL  GetURL(@"/merchant/user/merchant/qualificationsInfo")
/**
 *收款信息回填
 **/
#define receivablesInformation_URL  GetURL(@"/merchant/user/merchant/receivablesInfo")
/**
 *门店情况
 **/
#define storeInfoFileInformation_URL  GetURL(@"/merchant/user/merchant/storeInfoFile")
/**
 *门店未提交
 **/
#define merchantStoreInfoFileUnsubmitted_URL  GetURL(@"/merchant/user/merchant/storeInfoFileUnsubmitted")

/**
 *门店提交申请
 **/
#define storeInfoSubmitInformation_URL  GetURL(@"/merchant/user/merchant/storeInfoSubmit")

/**
 *门店基本资料
 **/
#define storeBasicInformation_URL  GetURL(@"/merchant/user/merchant/storeBasicInfo")
/**
 *获取省
 **/
#define userListProvinceName_URL  GetURL(@"/merchant/user/user/listProvinceName")
/**
 *获取市
 **/
#define userListCityName_URL  GetURL(@"/merchant/user/user/listCityName")
/**
 *获取县
 **/
#define userListDistrictName_URL  GetURL(@"/merchant/user/user/listDistrictName")

/**
 *获取省、城市、县
 **/
#define userMerchantListArea_URL  GetURL(@"/merchant/user/merchant/listArea")

/**
 *定位/搜索城市
 **/
#define merchantSearchCityByNameOPinYin_URL  GetURL(@"/merchant/user/merchant/searchCityByNameOPinYin")
/**
 *获取当前定位城市信息(通过name）
 **/
#define merchantGetIndexCity_URL  GetURL(@"/merchant/user/merchant/getIndexCity")
/**
 *按字母获取所有城市信息
 **/
#define merchantGetCityListOrderBy_URL  GetURL(@"/merchant/user/merchant/getCityListOrderBy")

/**
 *进行城市内地址的实时模糊检索
 **/
#define userMerchantSerarchShop_URL  GetURL(@"/merchant/user/merchant/serarchShop")

/**
 *嘿！附近/商品列表
 **/
#define merchantNearGoodsLlist_URL  GetURL(@"/merchant/user/merchant/nearGoodsLlist")
/**
 *获取经营类目
 **/
#define merchantSellCategorySearchForTree_URL  GetURL(@"/merchant/user/merchant/sellCategorySearchForTree")
/**
 *门店banner
 **/
#define activityRecommendStoreList_URL  GetURL(@"/merchant/user/activity/recommendStoreList")

/**
 *头条/列表
 **/
#define messageArticleList_URL  GetURL(@"/message/user/message/articleList")

/**
 *头条/内容
 **/
#define messageArticleDetail_URL  GetURL(@"/message/user/message/articleDetail")
/**
 *首页搜索
 **/
#define merchantSearchStore_URL  GetURL(@"/merchant/user/merchant/searchStore")

/**
 *首页热门搜索
 **/
#define merchantHotStore_URL  GetURL(@"/merchant/user/merchant/hotStore")

/**
 *首页最近搜索
 **/
#define merchantLatelySearch_URL  GetURL(@"/merchant/user/merchant/latelySearch")

/**
 *拼单/拼单列表
 **/
#define activityRigupOrderList_URL  GetURL(@"/merchant/user/activity/rigupOrderList")

/**
 *拼单/拼单详情
 **/
#define merchantRigupOrderDetail_URL  GetURL(@"/merchant/user/merchant/rigupOrderDetail")
/**
 *拼单/参与者消息轮播
 **/
#define activityRigupOrderMessage_URL  GetURL(@"/order/user/activity/rigupOrderMessage")
/**
 *列出有拼单商品的经营类目
 **/
#define merchantListRigupCategory_URL  GetURL(@"/merchant/user/merchant/listRigupCategory")
/**
 *店铺/拼单
 **/
#define activityStorerigUpOrder_URL  GetURL(@"/merchant/user/order/storerigUpOrder")


/**
 *赚客/分类
 **/
#define makeClassification_URL  GetURL(@"/user/activity/classification")


/**
 *赚客/列表
 **/
#define makeCustomersList_URL  GetURL(@"/merchant/user/merchant/makeCustomersList")

/**
 *赚客/列表
 **/
#define makeCustomersShare_URL  GetURL(@"/user/merchant/makeCustomersShare")

/**
 *赚客/详情
 **/
#define makeCustomersDetail_URL  GetURL(@"/user/makeCustomers/detail")


/**
 *分类/搜索
 **/
#define sellCategorySearch_URL  GetURL(@"/merchant/user/merchant/sellCategorySearch")


/**
 *添加商品到购车
 **/
#define orderCarAdd_URL  GetURL(@"/order/user/order/caradd")
/**
 *减少购物车商品
 **/
#define orderCarRemove_URL  GetURL(@"/order/user/order/carremove")
/**
 *清空购物车
 **/
#define orderCarClear_URL  GetURL(@"/order/user/order/carclear")
/**
 *购物车详情
 **/
#define orderCarDetail_URL  GetURL(@"/order/user/order/cardetail")

/**
 *店铺/分享商品
 **/
#define merchantShareGoods_URL  GetURL(@"/merchant/user/merchant/shareGoods")
/**
 *商品评论/评论列表
 **/
#define goodsCommentLlist_URL  GetURL(@"/order/user/user/goodsCommentLlist")
/**
 *店铺/商品详情
 **/
#define userStoreGoodsDetail_URL  GetURL(@"/merchant/user/storeGoodsDetail")

/**
 *店铺/门店列表
 **/
#define merchantStoreList_URL  GetURL(@"/merchant/user/merchant/storeList")

/**
 *店铺/门店列表筛选
 **/
#define merchantStoreListScreening_URL  GetURL(@"/merchant/user/merchant/storeList")

/**
 *店铺/门店搜索
 **/
#define merchantStoreListSearch_URL  GetURL(@"/user/merchant/storeList")
/**
 *店铺/店铺详情
 **/
#define merchantStoreDetail_URL  GetURL(@"/merchant/user/merchant/storeDetail")
/**
 *店铺/商品列表
 **/
#define merchantStoreGoodsLlist_URL  GetURL(@"/merchant/user/merchant/categoryGoodsLlist")
/**
 *店铺评价列表
 **/
#define merchantStorecommentslist_URL  GetURL(@"/order/user/user/shopCommentList")
/**
 *店铺/获取门店分类
 **/
#define merchantStoreCategory_URL  GetURL(@"/merchant/user/merchant/getStoreCategory")

/**
 *店铺/关注店铺
 **/
#define merchantFollowStore_URL  GetURL(@"/user/user/merchant/followStore")

/**
 *店铺/取消关注店铺
 **/
#define merchantUnsubscribeStore_URL  GetURL(@"/user/user/merchant/unsubscribeStore")

/**
 *店铺/分享店铺
 **/
#define merchantShareStore_URL  GetURL(@"/user/merchant/shareStore")

/**
 *优惠券/优惠活动
 **/
#define couponStoreCouponActivity_URL  GetURL(@"/coupon/user/coupon/storeCouponActivity")
/**
 *优惠券/领取优惠
 **/
#define couponGetCoupon_URL  GetURL(@"/coupon/user/user/getCoupon")

/**
 *优惠券/列表
 **/
#define couponStoreCouponList_URL  GetURL(@"/coupon/user/coupon/storeCouponList")

/**
 *店铺/店铺评分
 **/
#define merchantScoreStore_URL  GetURL(@"/user/merchant/scoreStore")

/**
 *消息/通知消息提醒
 **/
#define messageNoticeremind_URL  GetURL(@"/message/user/message/noticeremind")
/**
 *消息/来探店消息提醒
 **/
#define messageFindshopremind_URL  GetURL(@"/message/user/message/findshopremind")

/**
 *消息/消息列表
 **/
#define messagenoticelist_URL  GetURL(@"/message/user/message/noticelist")

/**
 *消息/来探店/Banner
 **/
#define messageFindshopBanner_URL  GetURL(@"/merchant/user/message/findshopbanner")

/**
 *消息/来探店/关注
 **/
#define messageFindshopList_URL  GetURL(@"/merchant/user/message/findconsernedshoplist")
/**
 *消息/来探店/未关注：推荐
 **/
#define messagefindunconsernedshoplistt_URL  GetURL(@"/merchant/user/message/findunconsernedshoplist")
/**
 *来探店点赞
 **/
#define messagefindShopGiveLike_URL  GetURL(@"/merchant/user/merchant/like")
/**
 *来探店取消点赞
 **/
#define messagefindShopCancelGiveLike_URL  GetURL(@"/merchant/user/merchant/unLike")
/**
 *来探店领取
 **/
#define messageindShopReceive_URL  GetURL(@"/merchant/user/message/findunconsernedshoplist")
/**
 *来探店分享
 **/
#define messagefindShopShare_URL  GetURL(@"/merchant/user/message/findunconsernedshoplist")
/**
 *订单/列表
 **/
#define orderList_URL  GetURL(@"/order/user/order/list")

/**
 *订单/获取消费码
 **/
#define orderGetcode_URL  GetURL(@"/order/user/order/getcode")

/**
 *订单/在店买单订单详情
 **/
#define orderPayinshopdiscount_URL  GetURL(@"/order/user/order/payinshopdiscount")

/**
 *订单/上门|外卖订单详情
 **/
#define orderTakeoutdetail_URL  GetURL(@"/order/user/order/takeoutdetail")

/**
 *订单/到店自取订单详情
 **/
#define orderShopdetail_URL  GetURL(@"/order/user/order/shopdetail")

/**
 *订单/订单详情
 **/
#define oorderDetail_URL  GetURL(@"/order/user/order/detail")
/**
 *订单/评价
 **/
#define orderAppraise_URL  GetURL(@"/order/user/order/appraise")
/**
 *订单/取消订单
 **/
#define orderCancel_URL  GetURL(@"/order/user/order/cancel")
/**
 *订单/退款
 **/
#define orderRefund_URL  GetURL(@"/order/user/order/refund")
/**
*订单/订单状态追踪
**/
#define orderTrace_URL  GetURL(@"/order/user/order/trace")
/**
 *订单/提交订单
 **/
#define orderSubmit_URL  GetURL(@"/order/user/order/submit")
/**
 *订单/获取订单支付信息
 **/
#define orderPayorderdetail_URL  GetURL(@"/order/user/order/payorderdetail")
/**
 *订单/支付
 **/
#define orderPay_URL  GetURL(@"/order/user/order/pay")
/**
 *订单/再来一单
 **/
#define againOrder_URL  GetURL(@"/order/user/order/pay")

/**
 *我的/本区域关注
 **/
#define concernInTheRegion_URL  GetURL(@"/user/user/user/concernInTheRegion")
/**
 *我的/其他区域关注
 **/
#define OtherTheRegion_URL  GetURL(@"/user/user/user/otherTheRegion")
/**
 *我的/采集足迹
 **/
#define footprintSave_URL  GetURL(@"/user/user/footprint/save")
/**
 *我的/足迹
 **/
#define footprintIndex_URL  GetURL(@"/user/user/footprint/index")
/**
 *我的/删除足迹
 **/
#define deleteFootprintIndex_URL  GetURL(@"/user/user/footprint/del")
/**
 *我的/评价/列表
 **/
#define EvaluationListr_URL  GetURL(@"/order/user/order/evaluationList")
/**
 *我的/卡券
 **/
#define userCardCouponList_URL  GetURL(@"/order/user/user/cardCouponList")

/**
 *地址/列表
 **/
#define userAddressList_URL  GetURL(@"/user/user/user/addressList")
/**
 *地址/默认地址
 **/
#define userGetAddressDefault_URL  GetURL(@"/user/user/user/getAddressDefault")

/**
 *地址添加
 **/
#define userAddAddress_URL  GetURL(@"/user/user/user/addressAdd")

/**
 *修改地址
 **/
#define userModifyAddress_URL  GetURL(@"/user/user/user/addressAdd")

/**
 *设为默认地址
 **/
#define userDefaultAddress_URL  GetURL(@"/user/user/user/addressDefault")

/**
 *删除地址
 **/
#define userDeleteAddress_URL  GetURL(@"/user/user/user/addressDel")
/**
 *邀请推荐/列表
 **/
#define userInvitationList_URL  GetURL(@"/user/user/user/InvitationList")

/**
 *邀请推荐/绑定归属商户
 **/
#define userInvitationBind_URL  GetURL(@"/user/user/user/InvitationBind")

/**
 *钱包/列表
 **/
#define userWalletList_URL  GetURL(@"/user/user/user/walletList")
/**
 *钱包/是否显示
 **/
#define userWalletisHide_URL  GetURL(@"/user/user/user/walletisHide")
/**
 *钱包/明细
 **/
#define userWalletisDetail_URL  GetURL(@"/user/user/user/walletisDetail")
/**
 *钱包/转账用户搜索
 **/
#define walletisTransferSearch_URL  GetURL(@"/user/user/user/walletisTransferSearch")
/**
 *钱包/转账金额最大限制
 **/
#define walletTransferAmountLimit_URL  GetURL(@"/user/user/user/walletisTransferMoney")

/**
 *钱包/转账
 **/
#define userWalletisTransfer_URL  GetURL(@"/user/user/user/walletisTransfer")
/**
 *银行卡列表
 **/
#define userBankCardList_URL  GetURL(@"/user/user/user/bankCardList")
/**
 *银行卡添加
 **/
#define userBankCardAdd_URL  GetURL(@"/user/user/user/bankCardAdd")
/**
 *银行卡设置默认
 **/
#define userBankCardDefault_URL  GetURL(@"/user/user/user/bankCardDefault")
/**
 *删除银行卡
 **/
#define userBankCardDelete_URL  GetURL(@"/user/user/user/bankCardDelete")

/**
 *消息设置/列表
 **/
#define messageSettingsList_URL  GetURL(@"/message/user/message/messageSettings")
/**
 *消息设置/保存
 **/
#define messageSave_URL  GetURL(@"/message/user/message/messageSave")
/**
 *我的设置
 **/
#define userMySettings_URL  GetURL(@"/user/user/user/mySettings")
/**
 *支付密码/验证支付密码
 **/
#define userVerifyPaymentPassword_URL  GetURL(@"/user/user/user/verifyPaymentPassword")
/**
 *我的/修改或添加支付密码(验证码)
 **/
#define userChangePaymentPassword_URL  GetURL(@"/user/user/user/changePaymentPassword")
/**
 *修改支付密码(支付密码版)
 **/
#define userChangePaymentPpw_URL  GetURL(@"/user/user/user/changePaymentPasswordPpw")

/**
 *手势密码/创建手势密码
 **/
#define userCreatGesturePassword_URL  GetURL(@"/user/user/user/changeGesturePassword")

/**
 *手势密码/验证手势密码
 **/
#define userVerifyGesturePassword_URL  GetURL(@"/user/user/user/verifyGesturePassword")


#endif /* RequestAPIHeader_h */
