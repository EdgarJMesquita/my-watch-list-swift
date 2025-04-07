//
//  AvatarUtils.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 06/04/25.
//

import Foundation

enum AvatarUtils {
    static func downloadAndFormat(user: User) async {
        let imageSize = CGSize(width: 25, height: 25)
 
        if
            let avatarPath = user.avatar.tmdb.avatarPath,
            let image = await ImageService.shared.downloadTMDBImage(path: avatarPath),
            let resizedImage = image.resizeImage(targetSize: imageSize),
            let data = resizedImage.jpegData(compressionQuality: 1)
        {
            PersistenceManager.saveAvatar(data: data)
        } else if
            let image = await ImageService.shared.downloadGravatar(hash: user.avatar.gravatar.hash),
            let resizedImage = image.resizeImage(targetSize: imageSize),
            let data = resizedImage.jpegData(compressionQuality: 1)
        {
            PersistenceManager.saveAvatar(data: data)
        }
        
    }
}
