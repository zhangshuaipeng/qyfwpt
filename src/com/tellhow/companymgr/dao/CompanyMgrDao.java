package com.tellhow.companymgr.dao;

import java.util.HashMap;
import java.util.List;

import com.siqiansoft.framework.model.LoginModel;

/**
 * 企业需求管理接口 
 * @author zhangsp
 *
 */
public interface CompanyMgrDao {
	/**
	 * 获取需求响应列表（对应平台中的记录集合）
	 * @param loginModel
	 * @return 平台的记录集合（需求响应管理下）
	 */
	public List<HashMap<String, String>> getDemandAnswerList(LoginModel loginModel);
	/**
	 * 保存需求信息（demand和demandmsg）
	 * @param loginModel
	 * @param map
	 */
	public void insertDemand(LoginModel loginModel,HashMap<String, String> map);
	/**
	 * 得到企业已审核需求列表
	 * @param loginModel
	 */
	public List<HashMap<String, String>> getCheckedDemandCom(LoginModel loginModel);
	/**
	 * 获得响应的服务机构列表（需求响应管理下）
	 * @param id 需求信息的id
	 */
	public List<HashMap<String, String>> getAnsweredService(String id);
	/**
	 * 获得申请的服务列表（企业服务申请下）
	 * @param loginModel
	 */
	public List<HashMap<String, String>> getAppliedService(LoginModel loginModel);
	/**
	 * 保存企业对服务机构提供服务的评价（企业服务申请下）
	 * 存在cs_server里,企业对服务机构所提供服务的评价（企业服务申请管理模块下）
	 * @param loginModel
	 * @param map 表单数据
	 */
	public void saveEvaluateByCom(LoginModel loginModel,HashMap<String, String> map);
	/**
	 * 保存企业的评价，企业发布的需求，有服务机构响应，对接成功后的评价
	 * 存在cs_demand里,在需求响应管理下
	 * @param loginModel
	 * @param map 表单数据
	 */
	public void saveEvaluateForDemand(LoginModel loginModel,HashMap<String, String> map);
	/**
	 * 企业发布需求后，服务机构去响应服务的合作
	 * @param id 需求关系表的id
	 * @return
	 */
	public HashMap<String, String> work(String id);
	/**
	 * 企业发布需求后，服务机构去响应服务的不合作
	 * @param id 需求关系表的id
	 * @return
	 */
	public List<HashMap<String, String>> notWork(String id);
	
	
}
