package main

import (
	"fmt"
	"math/rand"
	"strconv"
	//"sync"
	"time"
	"github.com/mikemintang/go-curl"
)

/* 有关Task任务相关定义及操作 */
//定义任务Task类型,每一个任务Task都可以抽象成一个函数
type Task struct {
	f func() error //一个无参的函数类型
}

//通过NewTask来创建一个Task
func NewTask(f func() error) *Task {
	t := Task{
		f: f,
	}
	return &t
}
//执行Task任务的方法
func (t *Task) Execute(work_ID string, p *Pool) {
	p.CurJobs += 1
	fmt.Println(p, " >> ", work_ID)
	t.f() //调用任务所绑定的函数
	fmt.Println("worker: ", work_ID, " 执行完毕")
	p.CurJobs -= 1
	p.Dealed += 1
}

/* 有关协程池的定义及操作 */
//定义池类型
type Pool struct {
	//对外接收Task的入口
	EntryChannel chan *Task
	//协程池最大worker数量,限定Goroutine的个数
	workerNum int
	//协程池内部的任务就绪队列
	JobsChannel chan *Task
	CurJobs int
	Dealed int
}
//创建一个协程池
func NewPool(max int) *Pool {
	p := Pool{
		EntryChannel: make(chan *Task),
		workerNum:   max,
		JobsChannel:  make(chan *Task),
		CurJobs: 0,
		Dealed: 0,
	}
	return &p
}
//协程池创建一个worker并且开始工作
func (p *Pool) worker(work_ID string) {
	//worker不断的从JobsChannel内部任务队列中拿任务
	for task := range p.JobsChannel {
		//如果拿到任务,则执行task任务
		fmt.Println("______task:", p.Dealed, "", p.CurJobs, "/", p.workerNum, p)
		task.Execute(work_ID, p)
		fmt.Println("----第 ", p.Dealed, "个任务 执行完毕")
	}
}
//让协程池Pool开始工作
func (p *Pool) Run() {
	//1,首先根据协程池的worker数量限定,开启固定数量的Worker,
	//  每一个Worker用一个Goroutine承载
	for i := 1; i <= p.workerNum; i++ {
		go p.worker(time.Now().Format("2006.01.02 15:04:05 ")+ strconv.Itoa(i))
	}
	//2, 从EntryChannel协程池入口取外界传递过来的任务
	//   并且将任务送进JobsChannel中
	for task := range p.EntryChannel {
		p.JobsChannel <- task
	}

	//3, 执行完毕需要关闭JobsChannel
	close(p.JobsChannel)

	//4, 执行完毕需要关闭EntryChannel
	close(p.EntryChannel)
}

func curlV (url string) string {
	headers := map[string]string{
		"User-Agent":    "Chrome/63.0.3239.132 (Windows NT 10.0; WOW64)",
		"Authorization": "Bearer access_token",
		"Content-Type":  "application/octet-stream",
	}
	// 链式操作
	req := curl.NewRequest()
	req.SetResponseTimeOut(10)
	resp, err := req.SetUrl(url).SetHeaders(headers).Get()

	if resp != nil {
		if resp.Raw.StatusCode == 200 {
			//fmt.Println(url, `StatusCode =`, resp.Raw.StatusCode)
			return resp.Body
		} else {
			fmt.Println(err, resp.Raw.StatusCode)
			return ""
		}
	}else{
		fmt.Println(err)
		return ""
	}
}


func main() {
	//curl
	urls := []string {"https://www.baidu.com", "https://www.php.net", "https://www.runoob.com"}
	fmt.Println()
	fmt.Println(urls)

	t := NewTask(func() error {
		fmt.Print("__")
		t1 := time.Now()
		r := rand.Int() % len(urls)
		curlV(urls[r])

		t2 := time.Now()

		fmt.Println(time.Now().Format("-- 2006-01-02 15:04:05"), t2.Sub(t1))
		return nil
	})

	//创建一个协程池,最大开启10个协程worker
	max := 10
	p := NewPool(max)

	//开一个协程 不断的向 Pool 输送打印一条时间的task任务
	go func() {
		for {
			p.EntryChannel <- t
			//time.Sleep(time.Duration(time.Microsecond * 200))
		}
	}()
	//启动协程池p
	p.Run()

    fmt.Printf("main OK!\n")
}