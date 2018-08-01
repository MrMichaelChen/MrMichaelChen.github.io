---
layout:     post
title:      面试中的排序算法
subtitle:   半天时间重新复习排序算法
date:       2018-07-26
author:     CDX
header-img: img/post-bg-ios9-web.jpg
catalog: true
tags:
    - 算法
    - Sort
    - 面试
---
## 冒泡排序
  
冒泡，可以想象得到的排序。    
就是想水中的小气泡那样一个一个往上爬，咿呀咿呀往上爬。  
举个例子5,3,7,6,4，从后往前开始看，4和6先比较，4比6小，所以交换位置，然后4与7比较，4比7小，所以交换位置，然后4与3比较，4与3比较，无需交换，所以不动，然后呢，就3与5比较，3比5小，ok!  3和5交换，这样一次冒泡完毕。得到了最小的数据3，然后依次对于剩下的序列进行冒泡就可以了。
```
    private static int[] bubblesort(int[] arr){
        if(arr==null || arr.length==0){
            return arr;
        }
        for(int num : arr){
            for(int i=arr.length-1;i>num;i--){
                if(arr[i]<arr[i-1]){
                    int temp = arr[i];
                    arr[i] = arr[i-1];
                    arr[i-1] = temp;
                }
            }
        }
        return arr;
    }
```
  
## 选择排序  
  
选择排序是对于整体的选择，对于以上例子5,3,7,6,4，首先选择5以外最小的数来交换，即3和5交换，依次排序后就变成了3,5,7,6,4，然后对剩下的序列进行选择和交换 ，最终可得到一个有序序列。

## 插入排序
  
插入排序是通过比较找到合适的位置插入元素来达到排序的目的。类似于斗地主时候的整理牌是的过程，抓牌、看牌、插入。这个原理和插入排序是一样的，还是5,3,7,4,6，首先假设第一个数的位置是正确的，在拿到第一张牌的时候没有必要整理，然后3来了，把3插到5的前面，把5往后移一个位置。然后第二次8不动，把6插在8的前面，8向后移一位，然后4插在5的前面，5向后移一位。移动时所有后面元素都要移位。  
  
## 快速排序（冒泡、二分、递归）
    
快排在实际应用中是表现最好的排序算法，其主要思想来自于冒泡排序，冒泡排序时通过相邻元素的比较和交换把最小的冒泡到最顶端，而快速排序是比较交换小数和大数，这样一来不仅把小数冒泡到上边同时把大数沉到下面。    
  
还是5,3,7,6,4，这个无序序列进行快速排序，右指针找比基准数小的，左指针找比基准数大的，交换之。
  
首先用5作为基准，最终会把比5小的移动到5的左边，把比5大的移动到5的右边。  
  
5,3,7,6,4，首先设置i、两个指针分别指向两端，j指针先扫描，4比5小停止，然后i扫描，7比5大停止，交换i、j的位置。
  
5,3,4,6,7，然后j指针重新扫描，这时扫描到4时两指针相遇，停止，然后基数和4交换。

4,3,5,6,7 一次划分后达到了5左边都比5小，5右边都比5大，然后对于左右两边再进行排序，最终获得有序序列。
  
```
private static void quicksort(int[] arr,int start,int end){

        // 如果列表为空则退出
        if (arr==null || arr.length==0){
            return;
        }
        // 设定基数为
        int pivotkey = arr[start];

        // 左指针、右指针
        int left = start;
        int right = end;

        // 当左指针小于右指针
        while(left < right){
            // 当右指针大于左指针，且右指针数大于基数，继续遍历，找小于基数的
            while(left<right && arr[right]>=pivotkey){
                right--;
            }
            // 当右指针等于左指针，或者右指针小于基数，while循环停止，将右指针的值赋给左指针
            arr[left] = arr[right];
            // 当左指针小于右指针，或者左指针小于基数，继续遍历，找大于基数的
            while(left<right && arr[left]<=pivotkey){
                left++;
            }
            // 当左指针等于右指针，或者左指针大于基数，while循环停止，将左指针的值赋给右指针
            arr[right] = arr[left];
        }
        // 基值赋给左指针
        arr[left] = pivotkey;
        // 若初始左指针找到比基数大的，说明没有完全排好序，递归
        if(left-1>start){
            quicksort(arr,start,left-1);
        }
        if(left+1<end){
            quicksort(arr,left+1,end);
        }
    }
```

```
  1 public class quicksort{
  2     public static void main(String[] args){
  3         int [] arr = {2,1,4,3,5,6};
  4         quicksortto(arr,0,4);
  5         for(int num:arr){
  6             System.out.println(num);
  7         }
  8     }
  9 
 10     public static int partition(int[] arr,int left,int right){
 11         int i = left;
 12         int x = arr[left];
 13         for(int j=left+1;j<right;j++){
 14             if(arr[j]<x)
 15             {
 16                 i++;
 17                 swap(arr,i,j);
 18             }
 19         }
 20         swap(arr,left,i);
 21         return i;
 22     }
 23 
 24     public static void quicksortto(int[] arr,int left,int right){
 25         if(left<right){
 26             int q=partition(arr,left,right);
 27             quicksortto(arr,left,q-1);
 28             quicksortto(arr,q+1,right);
 29         }
 30     }
 31 
 32     public static void swap(int [] arr,int a,int b){
 33         int buffer = arr[a];
 34         arr[a] = arr[b];
 35         arr[b] = buffer;
 36     }
 37 }


```



## 堆排序

堆排序是借助堆来实现的选择排序，思想同简单的选择排序，以下以大顶堆为例。注意：如果想升序排序就使用大顶堆，反之使用小顶堆。原因是堆顶元素需要交换到序列尾部。

???END
首先，实现堆排序需要解决两个问题：

1. 如何由一个无序序列键成一个堆？

2. 如何在输出堆顶元素之后，调整剩余元素成为一个新的堆？

第一个问题，可以直接使用线性数组来表示一个堆，由初始的无序序列建成一个堆就需要自底向上从第一个非叶元素开始挨个调整成一个堆。

第二个问题，怎么调整成堆？首先是将堆顶元素和最后一个元素交换。然后比较当前堆顶元素的左右孩子节点，因为除了当前的堆顶元素，左右孩子堆均满足条件，这时需要选择当前堆顶元素与左右孩子节点的较大者（大顶堆）交换，直至叶子节点。我们称这个自堆顶自叶子的调整成为筛选。


## 希尔排序
## 归并排序
## 计数排序
## 桶排序
## 计数排序


