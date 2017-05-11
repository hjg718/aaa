package team.user.model;

import java.util.Date;
import java.util.List;

import team.book.model.BookVo;

public class User {
	
	private UserVo vo;
	private List<RentalVo> rvoList;
	private List<BookVo> bvoList;
	
	public UserVo getVo() {
		return vo;
	}
	public void setVo(UserVo vo) {
		this.vo = vo;
	}
	public List<RentalVo> getRvoList() {
		return rvoList;
	}
	public void setRvoList(List<RentalVo> rvoList) {
		this.rvoList = rvoList;
	}
	public List<BookVo> getBvoList() {
		return bvoList;
	}
	public void setBvoList(List<BookVo> bvoList) {
		this.bvoList = bvoList;
	}
	
	
	
}
