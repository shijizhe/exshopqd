import axios from "axios";

export function request(config) {
   const instance = axios.create({
       baseURL:'http://localhost:8181',
       timeout: 5000
   })

    //请求拦截
    instance.interceptors.request.use(config=>{


        //直接放行
        return config;
    },err=>{})

    //响应拦截
    instance.interceptors.response.use(res=>{
        return res;
    },error => {
        //如果有错误,显示错误信息

    })
    return instance(config)
}