package team.user.model;

import java.util.HashMap;

import org.springframework.stereotype.Repository;



@Repository
public interface UserDao {
	public String check(String id);
	public int join(UserVo vo);
	public UserVo getvo(String id);
	public int edit(HashMap<String, Object> map);
	public int secession(String userid);

}
