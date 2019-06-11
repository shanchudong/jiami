package com.neusoft.ssm.interceptor;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    public  void afterComplertion (HttpServletRequest request, HttpServletResponse response,Object obj,Exception ex) throws Exception{
        super.afterCompletion(request,response,obj,ex);
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object obj, ModelAndView modelAndView)throws  Exception{
        super.postHandle(request,response,obj,modelAndView);
    }

    public boolean preHandle(HttpServletRequest request,HttpServletResponse response,Object obj)throws Exception{
//      request.getRequestURI(): 你输入的url  如果是login 直接跳转到login.jsp。如果不是的话直接
        String url = request.getRequestURI();
        System.out.println("拦截器:" + url + ":" + url.contains("login/login"));
        if(url.contains("login/login") ) {
            return true;
        }
        if(url.contains("login/implAdd")){
            return true;
        }
        if(url.contains("login/return")){
            return true;
        }
        if(url.contains("login/getQue/")){
            return true;
        }
        if(url.contains("login/verify")){
            return true;
        }

        //获取Session
        HttpSession session = request.getSession();
        String lgName = (String)session.getAttribute("lgName");
        if(lgName != null) {

//            String lgCate = (String)session.getAttribute("lgCate");
//            if(lgCate.equals("01") == true) {
//                if(url.contains("login/index01"))
//                    return true;
//                else
//                    return false;
//            }

            int data = (int)session.getAttribute("data");
            if(data != 0)
                return true;
        }
        request.setAttribute("msg", "你无权限访问系统资源，请先登录！");
        //不符合条件的，跳转到登录界面
        request.getRequestDispatcher("/WEB-INF/jsp/login/login.jsp").forward(request, response);
        return false;
    }
}

