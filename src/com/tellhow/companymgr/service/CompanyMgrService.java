package com.tellhow.companymgr.service;

import java.util.HashMap;
import java.util.List;

import com.siqiansoft.framework.model.LoginModel;
import com.tellhow.companymgr.dao.CompanyMgrDao;
import com.tellhow.companymgr.dao.impl.CompanyMgrDaoImpl;

/**
 * 企业管理业务类
 * @author zhangsp
 *
 */
public class CompanyMgrService {
	private CompanyMgrDao dao = new CompanyMgrDaoImpl();
	
	/**
	 * 获取需求响应列表（对应平台中的记录集合）
	 * @param loginModel
	 * @return 平台的记录集合（需求响应管理下）
	 */
	public List<HashMap<String, String>> getDemandAnswerList(LoginModel loginModel) {
		return dao.getDemandAnswerList(loginModel);
	}
	
	/**
	 * 保存需求信息（demand和demandmsg）
	 * @param loginModel
	 * @param map
	 */
	public void insertDemand(LoginModel loginModel,HashMap<String, String> map) {
		dao.insertDemand(loginModel, map);
	}
	/**
	 * 得到企业已审核需求列表
	 * @param loginModel
	 */
	public List<HashMap<String, String>> getCheckedDemandCom(LoginModel loginModel) {
		return dao.getCheckedDemandCom(loginModel);
	}
	/**
	 * 获得响应的服务机构列表（需求响应管理下）
	 * @param id 需求信息的id
	 */
	public List<HashMap<String, String>> getAnsweredService(String id) {
		return dao.getAnsweredService(id);
	}
	/**
	 * 获得申请的服务列表（企业服务申请下）
	 * @param loginModel
	 */
	public List<HashMap<String, String>> getAppliedService(LoginModel loginModel) {
		return dao.getAppliedService(loginModel);
	}
	/**
	 * 保存企业对服务机构提供服务的评价（企业服务申请下）
	 * 存在cs_server里,企业对服务机构所提供服务的评价（企业服务申请管理模块下）
	 * @param loginModel
	 * @param map 表单数据
	 */
	public void saveEvaluateByCom(LoginModel loginModel,HashMap<String, String> map){
		dao.saveEvaluateByCom(loginModel, map);
	}
	/**
	 * 保存企业的评价，企业发布的需求，有服务机构响应，对接成功后的评价
	 * 存在cs_demand里,在需求响应管理下
	 * @param loginModel
	 * @param map 表单数据
	 */
	public void saveEvaluateForDemand(LoginModel loginModel,HashMap<String, String> map){
		dao.saveEvaluateForDemand(loginModel, map);
	}
	/**
	 * 企业发布需求后，服务机构去响应服务的合作
	 * @param id 需求关系表的id
	 * @return
	 */
	public HashMap<String, String> work(String id){
		return dao.work(id);
	}
	/**
	 * 企业发布需求后，服务机构去响应服务的不合作
	 * @param id 需求关系表的id
	 * @return
	 */
	public List<HashMap<String, String>> notWork(String id){
		return dao.notWork(id);
	}
}
