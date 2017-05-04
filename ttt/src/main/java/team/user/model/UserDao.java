package team.user.model;

import org.springframework.stereotype.Repository;



@Repository
public interface UserDao {
	public String check(String id);
	public int join(UserVo vo);

}
