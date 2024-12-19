import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { APIResponse } from '../../../models/IAPIResponse';
import { HttpService } from '../../../services/HttpServices/http.service';
import { ResponseHandlerService } from '../../../services/HttpServices/response-handler.service';

interface MusicAlbum{

    title : string,
    description : string
}

@Component({
  selector: 'app-album',
  standalone: true,
  imports: [],
  templateUrl: './album.component.html',
  styleUrl: './album.component.css'
})
export class AlbumComponent {
    albumData: MusicAlbum = {
        title: '',
        description: ''
      };


    slug: string | null = null;
    isLoading : boolean = false;

    constructor(private route: ActivatedRoute,private httpService: HttpService, private responseHandler: ResponseHandlerService) {}

    ngOnInit(): void {
        this.slug = this.route.snapshot.paramMap.get('slug');
        this.loadAlbum();
      }


      loadAlbum(): void {
            this.isLoading = true;
            const response$: Observable<APIResponse<any>> = this.httpService.post('api/content', {
                Slug : this.slug,
                Type : "0"
            });
      
            this.responseHandler.handleResponse(response$, false).subscribe({
                next: (response) => {
                    console.log(response.data);
                    this.albumData =  JSON.parse(response.data.contentData) as MusicAlbum ;
                    console.log(this.albumData);
                    this.isLoading = false;
                },
                error: (error) => {
                    console.log(error.error);
                    this.isLoading = false;
                },
            });
        }
}
