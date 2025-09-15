//
//  PostCell.swift
//  KnowBody
//
//  Created by James Swinehart on 7/31/25.
//
import SwiftUI

struct PostCell: View {
    let post: Post
    
    var body: some View {
        
        VStack {
            HStack(alignment: .top, spacing: 12) {
                CircularProfileImageView(user: post.user, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        let first = post.user?.firstname ?? ""
                        let last = post.user?.lastname ?? ""
                        let title = post.user?.title ?? ""

                        let name = [first, last].filter { !$0.isEmpty }.joined(separator: " ")
                        let headerLine = [name, title].filter { !$0.isEmpty }.joined(separator: ", ")

                        Text(headerLine)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(post.timestamp.timestampString())
                            .font(.caption)
                            .foregroundColor(Color(.systemGray3))
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.blue))
                        }
                    }
                    
                    let specialties = post.user?.selectedSpecialties.joined(separator: ", ") ?? ""
                    let location = post.user?.location ?? ""
                    
                    Text("\(specialties), \(location)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(post.postTitle)
                        .font(.headline)
                        .padding(.top, 4)
                    
                    Label("\(String(post.age ?? 0)) • \(post.sex) • \(post.hasMedicalHistory ? "Relevant Medical History" : "No Medical History")", systemImage: "stethoscope")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text(post.description)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                            .lineLimit(2)
                        
                        Spacer(minLength: 48)
                    }
                    
                    Text("Looking for: \(post.selectedSpecialties.joined(separator: ", "))")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.top, 4)
                    
                    
                    HStack(spacing: 16) {
                        Button {
                            
                        } label: {
                            Image(systemName: "bubble.right")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            Divider()
        }
        .padding()
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: dev.post)
    }
}
